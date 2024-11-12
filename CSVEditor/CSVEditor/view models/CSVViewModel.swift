//
//  CSVViewModel.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI
import SwiftCSV

class CSVViewModel: ObservableObject {
    
    @Published var url: URL?
    @Published var content: String = ""
    @Published var headers: [CSVHeader] = []
    @Published var rows: [CSVRow] = []
    @Published var tableCustomization: TableColumnCustomization<CSVRow> = .init()
    
    init() {
        
    }
    
    required init(configuration: ReadConfiguration) throws {
        guard let data =  configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        guard let fileContent = String(data: data, encoding: .utf8) else { return }
        self.content = fileContent
        parseCSV(content: fileContent)
    }
    
    func handleFileImport(for result: Result<URL, Error>) {
        switch result {
            case .success(let url):
                readFile(url)
            case .failure(let error): print("error loading file \(error)")
        }
    }
    
    func readFile(_ url: URL) {
        guard url.startAccessingSecurityScopedResource() else { return }
        self.url = url
        
        do {
            let content = try String(contentsOf: url, encoding: .utf8)
            self.content = content
            parseCSV(content: content)
        } catch {
            print(error)
        }
        
        url.stopAccessingSecurityScopedResource()
    }
    
    func parseCSV(content: String) {
        do {
          let data = try EnumeratedCSV(string: content, loadColumns: false)
          
            self.headers = CSVHeader.createHeaders(data: data.header)
            self.rows =  data.rows.map({ CSVRow(cells:  $0.map({ CSVCell(content: $0) })) })
            
        } catch {
            print(error)
        }
    }
    
    //MARK: - Edit
    
    func delete(row: CSVRow, selection: Set<CSVRow.ID>) {
        if selection.contains(row.id) {
            self.rows.removeAll { selection.contains($0.id) }
        } else {
            self.rows.removeAll(where: { $0.id == row.id })
        }
    }
    
    func cellBinding(for row: CSVRow, header: CSVHeader) -> Binding<String> {
        Binding {
            if row.cells.count > header.columnIndex {
               return row.cells[header.columnIndex].content
            } else {
                return ""
            }
        } set: { newValue in
            if let rowIndex = self.rows.firstIndex(of: row) {
                self.rows[rowIndex].cells[header.columnIndex].content = newValue
            }
        }
    }
    
    //MARK: - Preview
    
    static var preview: CSVViewModel {
        let vm = CSVViewModel()
        vm.content = sampleCSV
        vm.parseCSV(content: sampleCSV)
        return vm
    }
    
    static var sampleCSV: String {
    """
    Keyword,Search volume
    swiftui components list,10
    swiftui list not showing,20
    swiftui uitableview,20
    swift tab view,20
    ios tabview,20
    table view swiftui,20
    table swiftui,20
    swift listview,30
    swift list view,30
    swiftui list example,30
    tabitem swiftui,30
    tableview swiftui,40
    tab bar swiftui,50
    swift ui table view,50
    swiftui table view,50
    """
    }
}

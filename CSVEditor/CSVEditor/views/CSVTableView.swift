//
//  CSVTableView.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI

struct CSVTableView: View {
    
    @ObservedObject var viewModel: CSVViewModel
    @State private var selection: Set<CSVRow.ID> = []
    
    var body: some View {
        Table(of: CSVRow.self,
              selection: $selection,
              columnCustomization: $viewModel.tableCustomization) {
            TableColumnForEach(viewModel.headers) { header in
                TableColumn(header.name) { row in
                    TextField("Cell",
                              text: viewModel.cellBinding(for: row, header: header))
                }
                .customizationID(header.id.uuidString)
            }
        } rows: {
            ForEach(viewModel.rows) { row in
                TableRow(row)
                    .contextMenu {
                        Button("Delete") {
                            withAnimation(.bouncy(duration: 2)) {
                                
                                viewModel.delete(row: row,
                                                 selection: selection)
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    CSVTableView(viewModel: CSVViewModel.preview)
}

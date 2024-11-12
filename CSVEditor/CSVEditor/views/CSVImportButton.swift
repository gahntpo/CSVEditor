//
//  CSVImportButton.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct CSVImportButton: View {
    
    @ObservedObject var viewModel: CSVViewModel
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Label("Import CSV", systemImage: "square.and.arrow.down")
        }
        .fileImporter(isPresented: $isPresented,
                      allowedContentTypes: [UTType.commaSeparatedText]) { result in
            viewModel.handleFileImport(for: result)
        }

    }
}

#Preview {
    CSVImportButton(viewModel: CSVViewModel())
}

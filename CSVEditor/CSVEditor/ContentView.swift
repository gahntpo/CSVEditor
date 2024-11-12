//
//  ContentView.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CSVViewModel
    
    var body: some View {
        CSVTableView(viewModel: viewModel)
        .toolbar {
            CSVImportButton(viewModel: viewModel)
            CSVExportButton(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView(viewModel: CSVViewModel.preview)
}

//
//  ContentView.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = CSVViewModel()
    
    var body: some View {
        
        CSVTableView(viewModel: viewModel)
        .toolbar {
            CSVImportButton(viewModel: viewModel)
            CSVExportButton(viewModel: viewModel)
        }
        .onOpenURL { url in
            viewModel.readFile(url)
        }
        .handlesExternalEvents(preferring: viewModel.url == nil ? [] : Set(viewModel.url!.lastPathComponent.components(separatedBy: .whitespaces)),
                               allowing: viewModel.url == nil ? ["*"] : [])
    }
}

#Preview {
    ContentView()
}

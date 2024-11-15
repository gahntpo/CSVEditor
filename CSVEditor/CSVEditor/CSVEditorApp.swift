//
//  CSVEditorApp.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import SwiftUI

@main
struct CSVEditorApp: App {
    var body: some Scene {
        DocumentGroup(viewing: CSVViewModel.self) { configuration in
            ContentView(viewModel: configuration.document)
        }
    }
}

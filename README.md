# CSVEditor
Shows how to make a macOS app that opens and edits CSV files. It is a  SwiftUI project using TableView, fileExporter, fileImporter, and ReferenceFileDocument. 

<img width="679" alt="SwiftUI TableView with CSV data" src="https://github.com/gahntpo/CSVEditor/blob/main/images/csvtable.jpeg">

## SwiftUI Table
MacOS 15 introduces dynamic table columns. This allows to show the imported csv data:

```
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
```


The table rows are selectable and have a context menu to delete the selected rows:

<img width="679" alt="Edit Data in SwiftUI TableView" src="https://github.com/gahntpo/CSVEditor/blob/main/images/tableedit.jpeg">

## Import CSV Files with SwiftUI

You can define what file types you want to allow. The following uses "commaSeparatedText" which corresponds to CSV files:

```
        .fileImporter(isPresented: $isPresented,
                      allowedContentTypes: [UTType.commaSeparatedText]) { result in
            viewModel.handleFileImport(for: result)
        }
```
<img width="879" alt="SwiftUI File importer with CSV files" src="https://github.com/gahntpo/CSVEditor/blob/main/images/fileimporter.jpeg">

## Document-Based app

The project is defined to use a document type for CSV files. This allows to open the app from Finder:

<img width="679" alt="Finder app open with dialog" src="https://github.com/gahntpo/CSVEditor/blob/main/images/openwith.jpeg">

You can get more functionality with DocumentGroup:
```
@main
struct CSVEditorApp: App {
    var body: some Scene {
        DocumentGroup(viewing: CSVViewModel.self) { configuration in
            ContentView(viewModel: configuration.document)
        }
    }
}
```

This includes "File" commands like save, open and move:


<img alt="SwiftUI TableView with CSV data" src="https://github.com/gahntpo/CSVEditor/blob/main/images/documentapp.jpeg">


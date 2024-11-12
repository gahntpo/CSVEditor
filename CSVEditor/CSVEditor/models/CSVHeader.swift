//
//  CSVHeader.swift
//  CSVEditor
//
//  Created by Karin Prater on 11/11/2024.
//

import Foundation

struct CSVHeader: Identifiable {
    var id: UUID = UUID()
    var name: String
    var columnIndex: Int = 0
    
    static func createHeaders(data: [String]) -> [CSVHeader] {
        var headers = data.map({ CSVHeader(name: $0) })
        
        var index = 0
        for (i,_) in headers.enumerated() {
            headers[i].columnIndex = index
            index += 1
        }
        
        return headers
    }
    
}

struct CSVRow: Identifiable, Equatable {
    var id: UUID = UUID()
    var cells: [CSVCell]
}

struct CSVCell: Identifiable, Equatable {
    var id: UUID = UUID()
    var content: String
    
    var exportContent: String {
        if content.contains(",") {
            return "\"\(content)\""
        } else {
            return content
        }
    }
}

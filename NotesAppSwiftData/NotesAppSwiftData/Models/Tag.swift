//
//  Tag.swift
//  NotesAppSwiftData
//
//  Created by Narayan Shettigar on 01/12/24.
//

import SwiftData

@Model
class Tag {
    @Attribute(.unique) var id: String
    var content: String
    
    @Relationship var notes: [Note]
    
    init(id: String, content: String, notes: [Note]) {
        self.id = id
        self.content = content
        self.notes = notes
    }
}

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
    @Attribute(.ephemeral) var isChecked: Bool = false
    var name: String
    
    @Relationship var notes: [Note]
    
    init(id: String, name: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.notes = notes
    }
}

//
//  Note.swift
//  NotesAppSwiftData
//
//  Created by Narayan Shettigar on 30/11/24.
//

import SwiftData

@Model
class Note {
    @Attribute(.unique) var id : String
    var content: String
    var createdAt: String
    
    @Relationship(inverse: \Tag.notes) var tags: [Tag]
    
    init(id: String, content: String, createdAt: String, tags: [Tag]) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.tags = tags
    }
}

//
//  TagListView.swift
//  NotesAppSwiftData
//
//  Created by Narayan Shettigar on 01/12/24.
//

import SwiftData
import SwiftUI

struct TagListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.name, order: .forward) var allTags: [Tag]
    @State var textFieldText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a tag") {
                    TextField(text: $textFieldText, axis: .vertical) {
                        Text("Enter a text")
                    }
                    .lineLimit(2...4)
                    
                    Button("Save") {
                        createNote()
                    }
                }
            }
            Section {
                if allTags.isEmpty {
                    ContentUnavailableView("You do not have any tags", systemImage: "tag")
                } else {
                    ForEach(allTags) { tag in
                        VStack(alignment: .leading) {
                            Text(tag.name)
                        }
                    }
                    .onDelete(perform: deleteNote)
                }
            }
        }
    }
    
    func createNote() {
        let tag = Tag(id: UUID().uuidString, name: textFieldText, notes: [])
        context.insert(tag)
        saveNotes()
    }
    
    func saveNotes() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        textFieldText = ""
    }
    
    func deleteNote(indexSet: IndexSet) {
        indexSet.forEach { index in
            context.delete(allTags[index])
            saveNotes()
        }
    }
}

#Preview {
    TagListView()
}

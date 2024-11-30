//
//  ContentView.swift
//  NotesAppSwiftData
//
//  Created by Narayan Shettigar on 30/11/24.
//

import SwiftUI
import SwiftData

struct NotesListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Note.createdAt, order: .reverse) var allNotes: [Note]
    @State var textFieldText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
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
                if allNotes.isEmpty {
                    ContentUnavailableView("You do not have any notes", systemImage: "note")
                } else {
                    ForEach(allNotes) { note in
                        VStack(alignment: .leading) {
                            Text(note.content)
                            Text(note.createdAt, style: .time)
                                .font(.caption)
                                
                        }
                    }
                    .onDelete(perform: deleteNote)
                }
            }
        }
    }
    
    func createNote() {
        let note = Note(id: UUID().uuidString, content: textFieldText, createdAt: .now)
        context.insert(note)
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
            context.delete(allNotes[index])
            saveNotes()
        }
    }
}

#Preview {
    NotesListView()
}

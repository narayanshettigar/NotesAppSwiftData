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
    @Query(sort: \Tag.name, order: .forward) var allTags: [Tag]
    @State var textFieldText = ""
    @State private var selectedTags: Set<Tag> = []
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Create a note") {
                    TextField(text: $textFieldText, axis: .vertical) {
                        Text("Enter a text")
                    }
                    .lineLimit(2...4)
                    
                    DisclosureGroup("Tags") {
                        if allTags.isEmpty {
                            Text("You do not have any tags")
                                .foregroundStyle(.gray)
                        }
                        
                        ForEach(allTags) { tag in
                            HStack {
                                Text(tag.name)
                                if tag.isChecked {
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .symbolRenderingMode(.multicolor )
                                }
                            }
                            .frame(alignment: .leading)
                            .clipShape(Rectangle())
                            .onTapGesture {
                                tag.isChecked.toggle()
                            }
                        }
                        .onDelete(perform: deleteNote)
                    }
                    
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

                            if note.tags.count > 0 {
                                Text("Tags:-" + note.tags.map { $0.name}.joined(separator: ", "))
                                    .font(.caption )
                            } else {
                                Text("Nothing")
                            }
                            
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
        var tags = [Tag]()
        allTags.forEach { tag in
            if tag.isChecked {
                print(tag.name)
                tags.append(tag)
            }
        }
        let note = Note(id: UUID().uuidString, content: textFieldText, createdAt: .now, tags: tags)
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

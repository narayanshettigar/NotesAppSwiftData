//
//  NotesAppSwiftDataApp.swift
//  NotesAppSwiftData
//
//  Created by Narayan Shettigar on 30/11/24.
//

import SwiftData
import SwiftUI

@main
struct NotesAppSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                notesList
                tagsList
            }
            .modelContainer(
                for: [
                    Note.self,
                    Tag.self
                ]
            )
        }
    }
}

var notesList: some View {
    NavigationStack {
        NotesListView()
            .navigationTitle("Notes")
    }
    .tabItem {
        Label("Notes", systemImage: "note")
    }
}

var tagsList: some View {
    NavigationStack {
        TagListView()
            .navigationTitle("Tags")
    }
    .tabItem {
        Label("Tags", systemImage: "tag")
    }
}

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
            ContentView()
                .modelContainer(
                    for: [
                        Note.self,
                        Tag.self
                    ]
                )
        }
    }
}

//
//  firstassignmentApp.swift
//  firstassignment
//
//  Created by Eric Wu on 9/8/24.
//

import SwiftUI
import FirebaseCore
import SwiftData

@main
struct firstassignmentApp: App {
    // Initialize Firebase in the init method
    init() {
        FirebaseApp.configure()
    }

    // SwiftData model container setup
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,  // Add any models if needed, currently you have `Item` class
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()  // Main content view
        }
        .modelContainer(sharedModelContainer)  // Attaching the model container for SwiftData
    }
}

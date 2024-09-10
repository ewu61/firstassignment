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

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            LoginView()  // Start with the login view
        }
        .modelContainer(sharedModelContainer)
    }
}

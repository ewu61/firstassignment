import SwiftUI
import FirebaseCore

@main
struct firstassignmentApp: App {
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
    }

    // Track if the user is logged in
    @State private var isUserLoggedIn = false

    var body: some Scene {
        WindowGroup {
            // Pass the `isUserLoggedIn` state as a binding to the LoginView
            if isUserLoggedIn {
                MainContentView()
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)  // Use $ to pass it as a binding
            }
        }
    }
}

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @State private var name: String = ""
    @State private var message: String = ""
    @State private var responseMessage: String = ""

    // Reference to Firestore
    let db = Firestore.firestore()

    var body: some View {
        VStack {
            Text("Send Message")
                .font(.headline)
                .padding()

            TextField("Enter your name", text: $name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Enter your message", text: $message)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                sendDataToFirebase()
            }) {
                Text("Send")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Text(responseMessage)
                .padding()
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    // Function to send data to Firestore
    func sendDataToFirebase() {
        // Create a timestamp for the message
        let timestamp = Date().timeIntervalSince1970
        
        // Create the data dictionary to send
        let data: [String: Any] = [
            "name": name,
            "message": message,
            "timestamp": timestamp
        ]

        // Add the data to Firestore under the "messages" collection
        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                // If there was an error, update the UI with the error message
                DispatchQueue.main.async {
                    responseMessage = "Error: \(error.localizedDescription)"
                }
            } else {
                // On success, clear the message and update the UI
                DispatchQueue.main.async {
                    responseMessage = "Message successfully sent!"
                    message = "" // Clear the message after sending
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

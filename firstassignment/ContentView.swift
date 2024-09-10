import SwiftUI
import FirebaseFirestore

struct SendMessageView: View {
    @Environment(\.presentationMode) var presentationMode  // Environment to handle dismiss
    @State private var name: String = ""
    @State private var messageText: String = ""
    @State private var sendMessageError: String = ""

    let db = Firestore.firestore()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Send a Message")
                    .font(.largeTitle)
                    .padding()

                TextField("Your Name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Your Message", text: $messageText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    sendMessage()
                }) {
                    Text("Send")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if !sendMessageError.isEmpty {
                    Text(sendMessageError)
                        .foregroundColor(.red)
                        .padding()
                }

                // Explicit Back button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()  // Dismiss the sheet
                }) {
                    Text("Back")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }

    // Function to send the message to Firestore
    func sendMessage() {
        let timestamp = Date()

        let data: [String: Any] = [
            "name": name,
            "message": messageText,
            "timestamp": Timestamp(date: timestamp)
        ]

        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                sendMessageError = "Error sending message: \(error.localizedDescription)"
            } else {
                // Reset the fields after successful message send
                name = ""
                messageText = ""
                sendMessageError = "Message sent successfully!"
            }
        }
    }
}

struct SendMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageView()
    }
}

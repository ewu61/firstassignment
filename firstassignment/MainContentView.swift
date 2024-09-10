import SwiftUI
import FirebaseFirestore

struct MainContentView: View {
    @State private var messages: [Message] = []  // Store fetched messages
    @State private var showSendMessageView = false  // To show the Send Message screen

    let db = Firestore.firestore()

    var body: some View {
        NavigationStack {
            VStack {
                // List to display messages
                List(messages) { message in
                    VStack(alignment: .leading) {
                        Text(message.name).font(.headline)
                        Text(message.text).font(.subheadline)
                        Text(message.timestamp.formatted()).font(.footnote).foregroundColor(.gray)
                    }
                }
                .onAppear(perform: fetchMessages)

                // Button to navigate to the Send Message screen
                Button(action: {
                    showSendMessageView = true
                }) {
                    Text("Send a Message")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showSendMessageView) {
                    SendMessageView()  // Navigates to the SendMessageView
                }
            }
            .padding()
            .navigationTitle("Messages")
        }
    }

    // Fetch messages from Firestore
    func fetchMessages() {
        db.collection("messages").order(by: "timestamp", descending: false).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching messages: \(error)")
            } else {
                // Map the snapshot data into Message model
                self.messages = querySnapshot?.documents.compactMap { document -> Message? in
                    let data = document.data()
                    guard let name = data["name"] as? String,
                          let text = data["message"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else {
                        return nil
                    }
                    return Message(id: document.documentID, name: name, text: text, timestamp: timestamp.dateValue())
                } ?? []
            }
        }
    }
}

// Model for a Message
struct Message: Identifiable {
    var id: String
    var name: String
    var text: String
    var timestamp: Date
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

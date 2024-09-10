import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginMessage: String = ""

    // Binding to track if the user is logged in
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if !loginMessage.isEmpty {
                    Text(loginMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                NavigationLink(destination: RegistrationView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    func loginUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                loginMessage = "Error: \(error.localizedDescription)"
            } else {
                loginMessage = "Logged in successfully!"
                // Switch to main content after successful login
                DispatchQueue.main.async {
                    isUserLoggedIn = true  // Update the binding to log the user in
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isUserLoggedIn: .constant(false))
    }
}

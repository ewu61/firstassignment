import SwiftUI

struct MainContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to the Main Content!")
                .font(.largeTitle)
                .padding()

            Text("You are successfully logged in.")
                .padding()
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

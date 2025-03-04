import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                Task {
                    do {
                        try await AuthRepository.logOut()
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Log Out")
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}

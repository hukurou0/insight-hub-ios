import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                Task {
                    do {
                        _ = try await BookRepository.create(userId: "000", title: "Test", author: "Who?", status: "未読", content: "Test", coverImage: nil)
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Upload")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

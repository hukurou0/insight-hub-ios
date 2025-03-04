import SwiftUI

struct SplashView: View {
    @Environment(ScreenController.self) private var screenController

    var body: some View {
        VStack {
            Spacer()
            Text("Insight Hub")
                .font(.title)
                .bold()
            Spacer()
        }
        .task {
            try? await Task.sleep(for: .seconds(1))
            if await AuthUseCase().isLoggedIn() {
                screenController.setScreen(.home)
            } else {
                screenController.setScreen(.auth)
            }
        }
    }
}

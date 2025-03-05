import SwiftUI

@main
struct InsightHubApp: App {
    @State private var screenController = ScreenController.shared

    var body: some Scene {
        WindowGroup {
            Group {
                switch screenController.current {
                case .splash:
                    SplashView()
                case .auth:
                    AuthView()
                case .home:
                    HomeView()
                }
            }
            .environment(screenController)
        }
    }
}

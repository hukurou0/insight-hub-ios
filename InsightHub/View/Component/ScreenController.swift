import SwiftUI

@Observable @MainActor
class ScreenController {
    enum Screen {
        case splash
        case auth
        case home
    }

    static let shared = ScreenController()
    private init() {}

    private(set) var current: Screen = .splash

    func setScreen(_ newScreen: Screen) {
        withAnimation {
            current = newScreen
        }
    }
}

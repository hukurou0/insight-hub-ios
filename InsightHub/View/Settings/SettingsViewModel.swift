import SwiftUI

@Observable @MainActor
class SettingsViewModel {
    var alertController = AlertController()
    private let authUseCase = AuthUseCase()
    private let screenController = ScreenController.shared
    private(set) var user: User?
    private(set) var isLoading = false

    func setUser() async {
        user = await authUseCase.getUser()
    }

    func logOut() {
        Task {
            defer {
                isLoading = false
            }
            do {
                isLoading = true
                try await authUseCase.logOut()
                screenController.setScreen(.auth)
            } catch {
                alertController.showAlert(mode: .error, message: "ログアウトに失敗しました。")
            }
        }
    }
}

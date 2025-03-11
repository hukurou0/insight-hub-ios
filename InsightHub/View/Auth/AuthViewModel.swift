import SwiftUI

enum AuthMode {
    case logIn
    case signUp

    var label: String {
        switch self {
        case .logIn:
            "ログイン"
        case .signUp:
            "新規登録"
        }
    }
}

@Observable @MainActor
class AuthViewModel {
    private let authUseCase = AuthUseCase()
    var alertController = AlertController()
    var screenController = ScreenController.shared

    var email = ""
    var password = ""
    var isLoading = false
    var mode: AuthMode = .logIn

    func authenticate() {
        Task {
            defer {
                isLoading = false
            }
            do {
                isLoading = true
                switch mode {
                case .logIn:
                    try await authUseCase.logIn(email: email, password: password)
                case .signUp:
                    try await authUseCase.signUp(email: email, password: password)
                }
                screenController.setScreen(.home)
            } catch {
                alertController.showAlert(mode: .error, message: "\(mode.label)に失敗しました。お手数ですが再度お試しくただい。")
            }
        }
    }
}

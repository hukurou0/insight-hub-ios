// REFERENCE: https://github.com/taka-2120/AlertPresentable

import SwiftUI

extension View {
    ///
    /// Show native alert using a `AlertController`.
    ///
    /// - parameter alertController: A binding variable of `AlertController`.
    ///
    func alert(using alertController: Binding<AlertController>) -> some View {
        modifier(CommonAlert(alertController: alertController))
    }
}

private struct CommonAlert: ViewModifier {
    @Binding var alertController: AlertController

    func body(content: Content) -> some View {
        content
            .alert(alertController.title, isPresented: $alertController.isPresented) {
                ForEach(alertController.actions) { action in
                    Button(role: action.role) {
                        if let action = action.action {
                            action()
                            return
                        }
                        alertController.isPresented = false
                    } label: {
                        Text(action.label)
                    }
                }
            } message: {
                Text(alertController.message)
            }
    }
}

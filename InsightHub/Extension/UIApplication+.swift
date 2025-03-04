import SwiftUI

@MainActor
extension UIApplication {
    static var screenWidth: CGFloat = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen.bounds.width ?? 0
}

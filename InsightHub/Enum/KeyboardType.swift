import UIKit

enum KeyboardType {
    case normal
    case emailAddress
    case password

    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .emailAddress:
            .emailAddress
        default:
            .default
        }
    }
}

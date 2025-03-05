// REFERENCE: https://github.com/taka-2120/AlertPresentable

import SwiftUI

@Observable
class AlertController {
    enum Mode: LocalizedStringKey {
        case error = "エラー"
        case warning = "警告"
        case message = "メッセージ"
    }

    ///
    /// Defines an action which is displayed as buttons in native alerts, and run on tapped.
    ///
    /// # Note #
    /// You CANNOT include the action to close. After custom `action` run, close the alert automatically.
    ///
    struct Action: Identifiable {
        let id = UUID()
        let label: LocalizedStringKey
        let role: ButtonRole?
        let action: (() -> Void)?

        ///
        /// - parameter label: The localizable label shown at the top of the native alert.
        /// - parameter role: The native button role which can be applied one of `destructive` or `cancel`. Default is `nil` to be a normal mode.
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert. Default is `nil` to just close the alert.
        ///
        init(label: LocalizedStringKey, role: ButtonRole? = nil, action: (() -> Void)? = nil) {
            self.label = label
            self.role = role
            self.action = action
        }

        ///
        /// - parameter label: The string label shown at the top of the native alert.
        /// - parameter role: The native button role which can be applied one of `destructive` or `cancel`. Default is `nil` to be a normal mode.
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert. Default is `nil` to just close the alert.
        ///
        init(label: String, role: ButtonRole? = nil, action: (() -> Void)? = nil) {
            self.label = "\(label)"
            self.role = role
            self.action = action
        }

        ///
        /// OK Button
        ///
        /// On tap, close the alert.
        ///
        static var ok: Self {
            .init(label: "OK")
        }

        ///
        /// OK Button
        ///
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert.
        ///
        static func ok(action: @escaping () -> Void) -> Self {
            .init(label: "OK", action: action)
        }

        ///
        /// Yes Button
        ///
        /// On tap, close the alert.
        /// Role is `destructive` by default.
        ///
        static var yes: Self {
            .init(label: "はい", role: .destructive)
        }

        ///
        /// Yes Button
        ///
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert.
        ///
        /// Role is `destructive` by default.
        ///
        static func yes(action: @escaping () -> Void) -> Self {
            .init(label: "はい", role: .destructive, action: action)
        }

        ///
        /// No Button
        ///
        /// On tap, close the alert.
        ///
        static var no: Self {
            .init(label: "いいえ", role: .cancel)
        }

        ///
        /// No Button
        ///
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert.
        ///
        static func no(action: @escaping () -> Void) -> Self {
            .init(label: "いいえ", role: .cancel, action: action)
        }

        ///
        /// Cancel Button
        ///
        /// On tap, close the alert.
        /// Role is `cancel` by default.
        ///
        static var cancel: Self {
            .init(label: "キャンセル", role: .cancel)
        }

        ///
        /// Cancel Button
        ///
        /// - parameter action: The custom action which is fired when the button was tapped just before close the alert.
        ///
        /// Role is `cancel` by default.
        ///
        static func cancel(action: @escaping () -> Void) -> Self {
            .init(label: "キャンセル", role: .cancel, action: action)
        }
    }

    var isPresented = false
    private(set) var title: LocalizedStringKey = ""
    private(set) var message: String = ""
    private(set) var actions: [Action] = []

    init() {}

    ///
    /// Call `showAlert` to configure the alert and show it.
    ///
    /// - parameter mode: The alert mode which is predefined and can be selected one of `error`, `warning`, or `message`. These enum name will be directly used as the title.
    /// - parameter message: The message shown just under the title.
    /// - parameter actions: The actions which can be set up multiple actions including predefined ones: `ok`, `yes`, `no`, and `cancel`. If it is empty, automatically applied `ok`. Items in the left of this array are displayed on the left.

    ///
    func showAlert(mode: Mode, message: String, actions: [Action] = [.ok]) {
        title = mode.rawValue
        self.message = message
        if actions.isEmpty {
            self.actions = [.ok]
        } else {
            self.actions = actions
        }
        isPresented = true
    }

    ///
    /// Call `showAlert` to configure the alert and show it.
    ///
    /// - parameter title: The localizable title shown at the top of the alert.
    /// - parameter message: The message shown just under the title.
    /// - parameter actions: The actions which can be set up multiple actions including predefined ones: `ok`, `yes`, `no`, and `cancel`. If it is empty, automatically applied `ok`. Items in the left of this array are displayed on the left.
    ///
    func showAlert(title: LocalizedStringKey, message: String, actions: [Action] = [.ok]) {
        self.title = title
        self.message = message
        if actions.isEmpty {
            self.actions = [.ok]
        } else {
            self.actions = actions
        }
        isPresented = true
    }
}

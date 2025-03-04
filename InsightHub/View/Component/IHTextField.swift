import SwiftUI

struct IHTextField: View {
    private let title: LocalizedStringKey
    private let keyboardType: KeyboardType
    private let capitalize: TextInputAutocapitalization?
    private let required: Bool
    @Binding private var text: String
    private let onSubmit: (() -> Void)?

    init(
        title: LocalizedStringKey,
        keyboardType: KeyboardType = .normal,
        capitalize: TextInputAutocapitalization? = nil,
        required: Bool = false,
        text: Binding<String>,
        onSubmit: (() -> Void)? = nil
    ) {
        self.title = title
        self.keyboardType = keyboardType
        self.capitalize = capitalize
        self.required = required
        _text = text
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .top) {
                Text(title)
                    .foregroundStyle(.secondary)
                if required {
                    Text("*")
                        .foregroundStyle(.red)
                }
            }
            if keyboardType == .password {
                SecureField(title, text: $text)
                    .textFieldStyle(IHTextFieldStyle())
                    .if(onSubmit != nil) { view in
                        view.onSubmit { onSubmit?() }
                    }
            } else {
                TextField(title, text: $text)
                    .textFieldStyle(IHTextFieldStyle())
                    .keyboardType(keyboardType.uiKeyboardType)
                    .textInputAutocapitalization(capitalize)
                    .if(onSubmit != nil) { view in
                        view.onSubmit { onSubmit?() }
                    }
            }
        }
    }
}

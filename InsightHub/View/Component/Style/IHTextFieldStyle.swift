import SwiftUI

struct IHTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(.clear)
            .cornerRadius()
            .stroke(color: Color(.systemGray5), lineWidth: 2)
    }
}

import SwiftUI

struct IHButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    let isLoading: Bool

    init(isLoading: Bool = false) {
        self.isLoading = isLoading
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if isLoading {
                ProgressView()
            }
            configuration.label
        }
        .animation(.spring, value: isLoading)
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundStyle(.white)
        .background(.blue)
        .opacity(configuration.isPressed ? 0.8 : 1)
        .opacity(!isEnabled ? 0.5 : 1)
        .cornerRadius()
    }
}

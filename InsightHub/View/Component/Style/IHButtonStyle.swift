import SwiftUI

struct IHButtonStyle: ButtonStyle {
    enum BackgroundStyle {
        case filled, outlined
    }

    @Environment(\.isEnabled) private var isEnabled: Bool
    let isLoading: Bool
    let background: BackgroundStyle
    let color: Color

    init(isLoading: Bool = false, background: BackgroundStyle = .filled, color: Color = .blue) {
        self.isLoading = isLoading
        self.background = background
        self.color = color
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if isLoading {
                ProgressView()
            }
            configuration.label
        }
        .animation(.bouncy, value: isLoading)
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundStyle(background == .outlined ? color : .white)
        .background(background == .filled ? color : .clear)
        .opacity(configuration.isPressed ? 0.8 : 1)
        .opacity(!isEnabled ? 0.5 : 1)
        .cornerRadius()
        .overlay {
            if background == .outlined {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
                    .stroke(color: color, lineWidth: 2)
            }
        }
    }
}

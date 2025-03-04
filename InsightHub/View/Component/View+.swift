import SwiftUI

extension View {
    nonisolated func cornerRadius(radius: CGFloat = 10) -> some View {
        clipShape(RoundedRectangle(cornerRadius: radius))
    }

    nonisolated func stroke(color: Color, lineWidth: CGFloat, radius: CGFloat = 10) -> some View {
        overlay {
            RoundedRectangle(cornerRadius: radius)
                .stroke(color, lineWidth: lineWidth)
        }
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`(_ condition: Bool, transform: (Self) -> some View) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

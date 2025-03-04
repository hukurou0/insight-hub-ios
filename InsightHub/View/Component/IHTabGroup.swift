import SwiftUI

struct IHTabView<Value: Hashable, Content: View>: View {
    private let selection: Binding<Value>
    private let content: Content
    private let maxWidth: CGFloat

    init(selection: Binding<Value>, maxWidth: CGFloat = UIApplication.screenWidth, @ViewBuilder content: () -> Content) {
        self.selection = selection
        self.maxWidth = maxWidth
        self.content = content()
    }

    var body: some View {
        HStack(spacing: 0) {
            _VariadicView.Tree(IHTabContent(maxWidth: maxWidth, selection: selection)) {
                content
            }
        }
    }
}

private struct IHTabContent<Value: Hashable>: _VariadicView.MultiViewRoot {
    let maxWidth: CGFloat
    let selection: Binding<Value>

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        ForEach(children) { child in
            IHTabButton(selection: selection, value: child[IHTabValueTraitKey<Value>.self]) {
                child
            }
            .frame(width: maxWidth / CGFloat(children.count) - 6)
            .padding(3)
        }
    }
}

private struct IHTabButton<Value: Hashable, Label: View>: View {
    private let selection: Binding<Value>
    private let value: Value?
    private let label: () -> Label

    private var isSelected: Bool {
        selection.wrappedValue == value
    }

    init(selection: Binding<Value>, value: IHTabValueTraitKey<Value>.Value, label: @escaping () -> Label) {
        self.selection = selection
        self.value = if case let .tagged(tag) = value {
            tag
        } else {
            nil
        }
        self.label = label
    }

    var body: some View {
        Button {
            guard let value else { return }
            withAnimation {
                selection.wrappedValue = value
            }
        } label: {
            VStack {
                label()
                    .foregroundStyle(isSelected ? .blue : Color(.label))
                    .padding()
                RoundedRectangle(cornerRadius: 3)
                    .fill(isSelected ? .blue : .clear)
                    .frame(height: 3)
            }
        }
    }
}

private struct IHTabValueTraitKey<V: Hashable>: _ViewTraitKey {
    enum Value {
        case untagged
        case tagged(V)
    }

    static var defaultValue: IHTabValueTraitKey<V>.Value {
        .untagged
    }
}

extension View {
    func tabValue<V: Hashable>(_ tag: V) -> some View {
        _trait(IHTabValueTraitKey<V>.self, .tagged(tag))
    }
}

#Preview {
    @Previewable @State var value = 1
    IHTabView(selection: $value) {
        Text("1")
            .tabValue(1)
        Text("2")
            .tabValue(2)
        Text("3")
            .tabValue(3)
    }
}

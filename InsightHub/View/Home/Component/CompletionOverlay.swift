import SwiftUI

struct CompletionOverlay: View {
    let book: BookModel
    let onClose: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }

            VStack(spacing: 20) {
                Text("本が追加されました! 🎉")
                    .font(.title2)
                    .bold()
                    .padding()

                if let url = book.coverImage {
                    AsyncImage(url: URL(string: url)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(radius: 30)
                                .frame(maxHeight: 300)
                                .shadow(color: .black.opacity(0.2), radius: 20, y: 5)
                        } else if let error = phase.error {
                            buildInvalidImagePlaceholder()
                        } else {
                            VStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(maxHeight: 300)
                            .background(.regularMaterial)
                            .cornerRadius(radius: 30)
                        }
                    }
                } else {
                    buildInvalidImagePlaceholder()
                }

                Text(book.title)
                    .font(.title)
                    .bold()

                HStack(spacing: 0) {
                    Text("\(book.author)")

                    if let category = book.category {
                        Text(" • ") + Text(category)
                    }
                }
                .foregroundStyle(.secondary)

                Link(destination: URL(string: Constant.URL.book(book.id).string)!) {
                    Text("Web で本の詳細を見る")
                }
                .buttonStyle(IHButtonStyle())

                Button {
                    onClose()
                } label: {
                    Text("閉じる")
                }
            }
            .padding(20)
            .background(.regularMaterial)
            .cornerRadius(radius: 30)
            .padding()
            .onAppear {
                Task {
                    try? await Task.sleep(for: .seconds(7))
                    onClose()
                }
            }
        }
    }

    private func buildInvalidImagePlaceholder() -> some View {
        VStack {
            Spacer()
            Image(systemName: "xmark")
                .foregroundStyle(.red)
                .font(.title)
            Text("画像を表示できません。")
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(maxHeight: 300)
        .background(.regularMaterial)
        .cornerRadius(radius: 30)
    }
}

#Preview {
    CompletionOverlay(book: .init(id: "1", title: "Test", author: "Who?", status: "Unread", userId: "1"), onClose: {})
}

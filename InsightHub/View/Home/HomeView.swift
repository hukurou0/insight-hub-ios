import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Button {
                    viewModel.isCreationSheetShown.toggle()
                } label: {
                    VStack(spacing: 20) {
                        Image(systemName: "plus")
                            .font(.system(size: 64))
                            .foregroundStyle(Color(.secondaryLabel))
                        Text("本を追加")
                            .foregroundStyle(Color(.label))
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.bottom, 100)

                Spacer()

                Link(destination: URL(string: Constant.URL.base.string)!) {
                    Text("Web 版を開く")
                }
                .buttonStyle(IHButtonStyle())
            }
            .padding()
            .navigationTitle("Insight Hub")
            .animation(.bouncy, value: viewModel.lastCreatedBook)
            .sheet(isPresented: $viewModel.isCreationSheetShown) {
                BookCreationView(lastCreatedBook: $viewModel.lastCreatedBook)
            }
            .sheet(isPresented: $viewModel.isSettingsSheetShown) {
                SettingsView()
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.isSettingsSheetShown.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.isCreationSheetShown.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .overlay {
            if let book = viewModel.lastCreatedBook {
                CompletionOverlay(book: book) {
                    viewModel.clearLastCreatedBook()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

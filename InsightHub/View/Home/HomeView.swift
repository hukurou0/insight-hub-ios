import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Group {
                    if let book = viewModel.lastCreatedBook, let url = book.coverImage {
                        VStack(spacing: 10) {
                            AsyncImage(url: URL(string: url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(radius: 30)
                                    .frame(maxHeight: 300)
                                    .shadow(color: .black.opacity(0.2), radius: 20, y: 5)
                            } placeholder: {
                                VStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 300)
                                .background(.regularMaterial)
                                .cornerRadius(radius: 30)
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

                            Text("本が追加されました!")
                                .bold()
                                .padding()
                        }
                    } else {
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
                    }
                }
                .padding(.bottom, 100)

                Spacer()

                Link(destination: URL(string: "https://insight-hub-kappa.vercel.app/")!) {
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
    }
}

#Preview {
    HomeView()
}

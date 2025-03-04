import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Button {
                    Task {
                        try? await AuthRepository.logOut()
                    }
                } label: {
                    Text("Log Out")
                }
            }
            .navigationTitle("Insight Hub")
            .sheet(isPresented: $viewModel.isCreationSheetShown) {
                BookCreationView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {} label: {
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

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = SettingsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    VStack(spacing: 15) {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 90, height: 90)
                            .overlay {
                                Text(user.email.first?.uppercased() ?? "Unknown")
                                    .foregroundStyle(.white)
                                    .font(.largeTitle)
                                    .bold()
                            }
                        Text(user.email)
                            .bold()
                    }
                    .padding()
                }

                Spacer()

                Button {
                    viewModel.logOut()
                } label: {
                    Text("ログアウト")
                }
                .buttonStyle(IHButtonStyle(isLoading: viewModel.isLoading, background: .outlined, color: .red))
                .disabled(viewModel.isLoading)
            }
            .padding()
            .navigationTitle("アカウント")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("閉じる")
                    }
                    .disabled(viewModel.isLoading)
                }
            }
            .task {
                await viewModel.setUser()
            }
            .onChange(of: viewModel.isLoading) { oldValue, newValue in
                if newValue == false, oldValue == true {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

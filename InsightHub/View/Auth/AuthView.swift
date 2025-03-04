import SwiftUI

struct AuthView: View {
    @State private var viewModel = AuthViewModel()

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 25) {
                Text("Insight Hub")
                    .font(.title)
                    .bold()

                Text("\"読むだけ\"で終わらない\n学びの新体験を")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack {
                IHTabView(selection: $viewModel.mode) {
                    Text(AuthMode.logIn.label)
                        .tabValue(AuthMode.logIn)
                    Text(AuthMode.signUp.label)
                        .tabValue(AuthMode.signUp)
                }

                VStack(spacing: 25) {
                    IHTextField(
                        title: "メールアドレス",
                        keyboardType: .emailAddress,
                        capitalize: .never,
                        text: $viewModel.email
                    )

                    IHTextField(
                        title: "パスワード",
                        keyboardType: .password,
                        text: $viewModel.password,
                        onSubmit: {
                            viewModel.authenticate()
                        }
                    )

                    Button {
                        viewModel.authenticate()
                    } label: {
                        Text(viewModel.mode.label)
                    }
                    .buttonStyle(IHButtonStyle(isLoading: viewModel.isLoading))
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                }
                .padding()
            }

            Spacer()
        }
        .alert(using: $viewModel.alertController)
    }
}

#Preview {
    AuthView()
}

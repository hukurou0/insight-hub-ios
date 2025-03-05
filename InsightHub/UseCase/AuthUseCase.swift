actor AuthUseCase {
    func logIn(email: String, password: String) async throws {
        let session = try await AuthRepository.logIn(email: email, password: password)
        await SessionRepository.shared.setSession(session)
    }

    func signUp(email: String, password: String) async throws {
        try await AuthRepository.signUp(email: email, password: password)
        let session = try await AuthRepository.getCurrentSession()
        await SessionRepository.shared.setSession(session)
    }

    func isLoggedIn() async -> Bool {
        let session = try? await AuthRepository.getCurrentSession()
        await SessionRepository.shared.setSession(session)
        return session != nil
    }

    func logOut() async throws {
        try await AuthRepository.logOut()
        await SessionRepository.shared.setSession(nil)
    }
}

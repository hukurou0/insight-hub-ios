class AuthRepository {
    static func logIn(email: String, password: String) async throws {
        try await Supabase.client.auth.signIn(email: email, password: password)
    }

    static func signUp(email: String, password: String) async throws {
        try await Supabase.client.auth.signUp(email: email, password: password)
    }
}

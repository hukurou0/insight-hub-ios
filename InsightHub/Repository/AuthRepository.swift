import Auth

class AuthRepository {
    static func logIn(email: String, password: String) async throws -> Session {
        try await Supabase.client.auth.signIn(email: email, password: password)
    }

    static func signUp(email: String, password: String) async throws -> Session {
        let response = try await Supabase.client.auth.signUp(email: email, password: password)
        guard let session = response.session else {
            throw AuthError.noSessionFound
        }
        return session
    }

    static func getCurrentSession() async throws -> Session {
        try await Supabase.client.auth.session
    }

    static func logOut() async throws {
        try await Supabase.client.auth.signOut()
    }
}

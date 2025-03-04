import Auth

class AuthRepository {
    @discardableResult
    static func logIn(email: String, password: String) async throws -> User {
        let response = try await OpenAPI.client().signIn(body: .json(.init(email: email, password: password)))
        return try response.ok.body.json
    }

    static func signUp(email: String, password: String) async throws {
        _ = try await OpenAPI.client().signUp(body: .json(.init(email: email, password: password)))
    }

    static func getCurrentSession() async throws -> User {
        let response = try await OpenAPI.client().getSession()
        return try response.ok.body.json
    }

    static func logOut() async throws {
        _ = try await OpenAPI.client().signOut()
    }
}

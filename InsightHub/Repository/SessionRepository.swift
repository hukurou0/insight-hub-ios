actor SessionRepository {
    static let shared = SessionRepository()
    private init() {}

    private(set) var session: User?

    func setSession(_ session: User?) {
        self.session = session
    }
}

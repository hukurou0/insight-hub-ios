import Auth

actor SessionRepository {
    static let shared = SessionRepository()
    private init() {}

    private(set) var session: Session?

    func setSession(_ session: Session) {
        self.session = session
    }
}

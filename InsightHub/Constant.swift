enum Constant {
    enum URL {
        case base
        case book(String)

        var string: String {
            switch self {
            case .base: "https://insight-hub-kappa.vercel.app/"
            case let .book(id): "https://insight-hub-kappa.vercel.app/#/books/\(id)"
            }
        }
    }
}

import OpenAPIURLSession

class OpenAPI {
    static func client() throws -> Client {
        #if DEBUG
            let serverUrl = try Servers.Server1.url()
        #else
            let serverUrl = try Servers.Server2.url()
        #endif

        return Client(
            serverURL: serverUrl,
            transport: URLSessionTransport()
        )
    }
}

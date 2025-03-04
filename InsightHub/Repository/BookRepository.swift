import Foundation
import OpenAPIURLSession

class BookRepository {
    static func create(
        userId: String,
        title: String,
        author: String,
        status: String,
        content: String,
        coverImage: String?
    ) async throws -> BookModel {
        let response = try await OpenAPI.client().createBook(
            headers: .init(userId: userId),
            body: .json(
                .init(
                    title: title,
                    author: author,
                    status: BookStatus(rawValue: status) ?? .未読,
                    content: content,
                    coverImage: coverImage
                )
            )
        )
        return try response.ok.body.json
    }

    static func uploadImage(_ imageData: Data) async throws -> UploadedBookImageData {
        let response = try await OpenAPI.client().uploadBookImage(body: .multipartForm(
            [.file(
                .init(payload: .init(body: .init(imageData.base64EncodedString())))
            )]
        ))

        return try response.ok.body.json
    }

    static func analyze(userId: String, coverImage: Data) async throws -> BookAnalysisResult {
        let response = try await OpenAPI.client().analyzeBook(
            headers: .init(userId: userId),
            body: .json(
                .init(
                    imageBase64: coverImage.base64EncodedString()
                )
            )
        )

        return try response.ok.body.json
    }
}

import Foundation

class BookUseCase {
    func create(
        title: String,
        author: String,
        status: String,
        content: String,
        coverImageURL: String?
    ) async throws -> BookModel {
        let session = await SessionRepository.shared.session
        guard let userId = session?.user.id else { throw AuthError.noSessionFound }
        return try await BookRepository.create(
            userId: userId.uuidString,
            title: title,
            author: author,
            status: status,
            content: content,
            coverImage: coverImageURL
        )
    }

    func uploadImage(_ imageData: Data) async throws -> UploadedBookImageData {
        try await BookRepository.uploadImage(imageData)
    }

    func analyzeImage(for coverImage: Data) async throws -> BookAnalysisResult {
        let session = await SessionRepository.shared.session
        guard let userId = session?.user.id else { throw AuthError.noSessionFound }
        return try await BookRepository.analyze(userId: userId.uuidString, coverImage: coverImage)
    }
}

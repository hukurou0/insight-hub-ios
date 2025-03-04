import Foundation

actor BookUseCase {
    func create(
        title: String,
        author: String,
        category: BookCategory?,
        coverImageURL: String?
    ) async throws -> BookModel {
        let session = await SessionRepository.shared.session
        guard let userId = session?.id else { throw AuthError.noSessionFound }
        return try await BookRepository.create(
            userId: userId,
            title: title,
            author: author,
            category: category?.rawValue,
            coverImageURL: coverImageURL
        )
    }

    func uploadImage(_ imageData: Data) async throws -> UploadedBookImageData {
        try await BookRepository.uploadImage(imageData)
    }

    func analyzeImage(for coverImage: Data) async throws -> BookAnalysisResult {
        try await BookRepository.analyze(coverImage: coverImage)
    }
}

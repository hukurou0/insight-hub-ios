import PhotosUI
import SwiftUI

@Observable @MainActor
class BookCreationViewModel {
    var bookUseCase = BookUseCase()
    var alertController = AlertController()

    var isCameraPickerShown = false
    var imageItem: PhotosPickerItem?
    var imageData: Data?
    var isImageBeingAnalyzed = false

    var bookImageData: UploadedBookImageData?
    var bookAnalysisResult: BookAnalysisResult?
    var title = ""
    var author = ""
    var category: BookCategory?
    var isSaving = false
    var lastCreatedBook: Binding<BookModel?>

    init(lastCreatedBook: Binding<BookModel?>) {
        self.lastCreatedBook = lastCreatedBook
    }

    func processImagePickedByLibrary() {
        Task {
            do {
                guard let imageData = try await imageItem?.loadTransferable(type: Data.self) else {
                    self.imageData = nil
                    return
                }

                withAnimation {
                    self.imageData = imageData
                }
            } catch {
                fatalError("Failed to process an image")
            }
        }
    }

    func processImagePickedByCamera(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            imageData = nil
            return
        }

        withAnimation {
            self.imageData = imageData
        }
    }

    func analyzeImage() {
        Task {
            defer {
                isImageBeingAnalyzed = false
            }
            do {
                guard let imageData else { return }
                isImageBeingAnalyzed = true
                let result = try await bookUseCase.analyzeImage(for: imageData)
                withAnimation(.bouncy) {
                    bookAnalysisResult = result
                    title = result.title ?? ""
                    author = result.author ?? ""
                    if let categoryStr = result.category, let category = BookCategory(rawValue: categoryStr) {
                        self.category = category
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func save() {
        Task {
            defer {
                isSaving = false
            }
            do {
                guard let imageData else { return }
                isSaving = true
                let uploadedImageData = try await bookUseCase.uploadImage(imageData)
                let newBook = try await bookUseCase.create(title: title, author: author, category: category, coverImageURL: uploadedImageData.url)
                lastCreatedBook.wrappedValue = newBook
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func clearAnalyzedData() {
        withAnimation(.bouncy) {
            imageItem = nil
            imageData = nil
            bookAnalysisResult = nil
            title = ""
            author = ""
            category = nil
        }
    }

    func clearImageData() {
        withAnimation {
            imageItem = nil
            imageData = nil
        }
    }
}

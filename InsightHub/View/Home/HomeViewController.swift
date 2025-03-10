import SwiftUI

@Observable
class HomeViewModel {
    var isCreationSheetShown = false
    var isSettingsSheetShown = false

    var lastCreatedBook: BookModel?

    func clearLastCreatedBook() {
        withAnimation {
            lastCreatedBook = nil
        }
    }
}

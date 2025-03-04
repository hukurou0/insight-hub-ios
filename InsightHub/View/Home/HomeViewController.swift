import SwiftUI

@Observable
class HomeViewModel {
    var isCreationSheetShown = false

    var lastCreatedBook: BookModel?
}

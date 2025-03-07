import SwiftUI

@Observable
class HomeViewModel {
    var isCreationSheetShown = false
    var isSettingsSheetShown = false

    var lastCreatedBook: BookModel?
}

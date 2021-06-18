import Foundation
import CoreKit

enum OnArtsListLog: Loggable {
    case artDidAppearWithoutShowingPage(artIdentifier: String)
    case retryTappedWithoutShowingPage
    case showingPage(pageIndex: Int)
    case nonExistentArtSelected(artIdentifier: String)
    var logDescription: String {
        switch self {
        case let .artDidAppearWithoutShowingPage(artIdentifier):
            return "Art(identifier: \(artIdentifier)) Did Appear without showing Any Page"
        case let .showingPage(pageIndex):
            return "Currently presenting page with index \(pageIndex)"
        case .retryTappedWithoutShowingPage:
            return "Retry was tapped without showing Any Page"
        case let .nonExistentArtSelected(artIdentifier):
            return "Non existent Art(\(artIdentifier) was selected"
        }
    }
}

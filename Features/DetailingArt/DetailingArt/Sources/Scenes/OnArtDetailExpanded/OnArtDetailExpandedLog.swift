import Foundation
import CoreKit

enum OnArtDetailExpandedLog: Loggable {
    case fullSizeRequestedWithoutArtDetail
    case showingPage(pageIndex: Int)
    case retriedLoadCommentsWithNoCurrentArt
    case commentDidAppearWithoutNoCommentsPage
    var logDescription: String {
        switch self {
        case let .showingPage(pageIndex):
            return "Currently presenting comments page with index \(pageIndex)"
        case .fullSizeRequestedWithoutArtDetail:
            return "User selected full size option without a art detail be presented"
        case .retriedLoadCommentsWithNoCurrentArt:
            return "User selected retry load comments when there is no art been showed"
        case .commentDidAppearWithoutNoCommentsPage:
            return "Comment did appear but there is no comment page been showed"
        }
    }
}

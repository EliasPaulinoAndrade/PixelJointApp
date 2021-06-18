import Foundation
import CoreKit

enum OnAppStartLog: Loggable {
    case opennedAppWithoutCachedPixelArt
    case opennedAppWithCachedPixelArt(artLink: URL)
    var logDescription: String {
        switch self {
        case .opennedAppWithoutCachedPixelArt:
            return "Openned app but there is no pixel art openned"
        case let .opennedAppWithCachedPixelArt(artLink):
            return "Openned app with openned art: \(artLink)"
        }
    }
}

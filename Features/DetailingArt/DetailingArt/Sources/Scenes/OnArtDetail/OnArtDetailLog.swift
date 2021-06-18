import Foundation
import CoreKit

enum OnArtDetailLog: Loggable {
    case needRetryWithoutArtURL
    case needMaximazeWithoutArtURL
    var logDescription: String {
        switch self {
        case .needRetryWithoutArtURL:
            return "Retry was selected when there is no current art URL"
        case .needMaximazeWithoutArtURL:
            return "Maximize was selected when there is no current art URL"
        }
    }
}

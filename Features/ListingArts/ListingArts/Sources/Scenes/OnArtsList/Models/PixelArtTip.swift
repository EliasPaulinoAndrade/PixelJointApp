import Foundation
import WebScrapingKitInterface

struct PixelArtTip: HTMLDecodable {
    let title: String
    
    public init(container: HTMLContaining) throws {
        title = try container.decode(
            path: .selector("a"), .content,
            type: String.self
        ).justOne()
    }
}

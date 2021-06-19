import Foundation
import WebScrapingKitInterface

struct PixelArt: HTMLDecodable {
    let image: String
    let link: URL
    let identifier: String = UUID().uuidString
    
    public init(container: HTMLContaining) throws {
        image = try container.decode(
            path: .selector("img"), .attributte("src"),
            type: String.self
        ).justOne()
        
        link = try container.decode(
            path: .selector("a"), .attributte("href"),
            type: URL.self
        ).justOne()
    }
}

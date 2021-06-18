import Foundation
import WebScrapingKitInterface

struct PixelArt: HTMLDecodable {
    let image: String
    let link: URL
    let identifier: String
    
    public init(container: HTMLContaining) throws {
        image = try container.decode(
            path: .selector("img"), .attributte("src"),
            type: String.self
        ).justOne()
        
        link = try container.decode(
            path: .selector("a"), .attributte("href"),
            type: URL.self
        ).justOne()
        
        guard let identifier = link.lastPathComponent.split(separator: ".").first else {
            self.identifier = UUID().uuidString
            return
        }
        
        self.identifier = String(identifier)
    }
}

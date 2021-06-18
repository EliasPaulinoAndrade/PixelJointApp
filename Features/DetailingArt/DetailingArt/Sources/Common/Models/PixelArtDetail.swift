import Foundation
import WebScrapingKitInterface

struct PixelArtDetail: HTMLDecodable {
    let detailImage: String
    let title: String
    let authorName: String
    let description: String
    let favoritesCount: String?
    let commentsCount: String?
    let smallImage: String?
    
    init(container: HTMLContaining) throws {
        detailImage = try container.decode(
            path: .identifier("mainimg"), .attributte("src"),
            type: String.self
        ).justOne()
        
        title = try container.decode(
            path: .selector("strong:contains(Title)"), .parent, .sibling, .content,
            type: String.self
        ).justOne()
        
        authorName = try container.decode(
            path: .selector("strong:contains(Pixel Artist:)"), .parent, .sibling, .selector("a"), .content,
            type: String.self
        ).justOne()
        
        let description = try? container.decode(
            path: .identifier("leftblockspan"), .selector("tbody tbody tr td:only-of-type"), .content,
            type: String.self
        ).justOne()
        
        self.description = description ?? ""
        
        smallImage = try? container.decode(
            path: .identifier("smallimg"), .attributte("src"),
            type: String.self
        ).justOne()
        
        (commentsCount, favoritesCount) = PixelArtDetail.getCounts(container: container)
    }
    
    private static func getCounts(container: HTMLContaining) -> (faves: String?, comments: String?) {
        let countsContainer = try? container.decode(
            path: .selector(".clean .tablet-span:contains(comments)"), .parent, .text,
            type: String.self
        ).justOne()
        
        guard let commentsComponents = countsContainer?.components(separatedBy: "comments"),
              let commentsCount = commentsComponents.first?.trimmingCharacters(in: .whitespaces) else {
            return (nil, nil)
        }
        
        guard commentsComponents.count >= 2 else {
            return (commentsCount, nil)
        }
        
        let favesComponents = commentsComponents[1].components(separatedBy: "faves")
        guard let favesCount = favesComponents.first?.trimmingCharacters(in: .whitespaces) else {
            return (commentsCount, nil)
        }
        
        return (commentsCount, favesCount)
    }
}

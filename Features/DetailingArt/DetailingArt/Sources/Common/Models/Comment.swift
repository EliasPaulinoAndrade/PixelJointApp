import Foundation
import WebScrapingKitInterface

struct Comment: HTMLDecodable {
    let author: String
    let message: String
    let avatarImage: String
    let identifier = UUID().uuidString
    
    init(container: HTMLContaining) throws {
        author = try container.decode(
            path: .className("postedby"), .selector("a"), .content,
            type: String.self
        ).all().first ?? ""
        
        avatarImage = try container.decode(
            path: .className("avatar"), .selector("img"), .attributte("src"),
            type: String.self
        ).justOne()
        
        let allComment = try container.decode(
            path: .className("comment"), .text,
            type: String.self
        ).justOne()
        
        let justAuthor = try container.decode(
            path: .className("postedby"), .text,
            type: String.self
        ).justOne()

        message = allComment.replacingOccurrences(of: justAuthor, with: "")
            .trimmingCharacters(in: .whitespaces)
    }
}

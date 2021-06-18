import Foundation
import WebScrapingKitInterface

struct CommentPage: HTMLDecodable {
    let comments: [Comment]
    let pagesTotal: Int
    
    init(container: HTMLContaining) throws {
        pagesTotal = CommentPage.getPagesTotal(container: container)
        
        let comments = try? container.decode(
            path: .className("avatar"), .parent,
            type: Comment.self
        ).all()
        
        self.comments = comments ?? []
    }
    
    private static func getPagesTotal(container: HTMLContaining) -> Int {
        let allPageContent = try? container.decode(
            path: .className("pager-select-holder"), .text,
            type: String.self
        ).all().joined()
        
        let otherPageContent = try? container.decode(
            path: .className("pager-select-holder"), .selector("select, script"), .text,
            type: String.self
        ).all().joined()
        
        if let allPageContent = allPageContent, let otherPageContent = otherPageContent {
            let pageNumberString = allPageContent.replacingOccurrences(of: otherPageContent, with: "")
            let pageNumber = pageNumberString.components(separatedBy: .decimalDigits.inverted).joined()
            return Int(pageNumber) ?? 1
        }
        return 1
    }
}

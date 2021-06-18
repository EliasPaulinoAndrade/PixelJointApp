import Foundation
import WebScrapingKitInterface

struct PixelArtGallery: HTMLDecodable {
    let pixelArts: [PixelArt]
    let pixelArtsTips: [PixelArtTip]
    let pagesTotal: Int
    
    public init(container: HTMLContaining) throws {
        pagesTotal = PixelArtGallery.getPagesTotal(container: container)
        
        pixelArts = try container.decode(
            path: .className("imgbox"),
            type: PixelArt.self
        ).all()
        
        pixelArtsTips = try container.decode(
            path: .className("tooltip"),
            type: PixelArtTip.self
        ).all()
    }
    
    private static func getPagesTotal(container: HTMLContaining) -> Int {
        let pagesTotalString = try? container.decode(
            path: .className("pager-select-holder"), .text,
            type: String.self
        ).justOne().components(separatedBy: "of").last?.trimmingCharacters(in: .whitespaces)
        
        if let pagesTotalString = pagesTotalString {
            return Int(pagesTotalString) ?? 1
        }
        
        return 1
    }
}

import Foundation
import SwiftSoup
import WebScrapingKitInterface

extension Element {
    func searchElements(at path: PathElement...) throws -> [SearchResult] {
        try searchElements(atPath: path)
    }
    
    func searchElements(atPath path: [PathElement]) throws -> [SearchResult] {
        guard let firstPath = path.first else {
            return [.element(self)]
        }
        
        let nextPath = Array(path.dropFirst())
        let resultElements: [Element]

        switch firstPath {
        case let .selector(identifier):
            resultElements = try select(identifier).array()
        case let .className(identifier):
            resultElements = try getElementsByClass(identifier).array()
        case let .identifier(identifier):
            guard let element = try getElementById(identifier) else {
                resultElements = []
                break
            }
            resultElements = [element]
        case .parent:
            guard let element = parent() else {
                resultElements = []
                break
            }
            resultElements = [element]
        case .sibling:
            resultElements = siblingElements().array()
        case .children:
            resultElements = children().array()
        case .text:
            return [.attributte(try text())]
        case .content:
            return [.attributte(try html())]
        case let .attributte(identifier):
            return [.attributte(try attr(identifier))]
        }
                
        guard !nextPath.isEmpty else {
            return resultElements.map { element in
                .element(element)
            }
        }
                        
        return try resultElements.flatMap { nextElement -> [SearchResult] in
            try nextElement.searchElements(atPath: nextPath)
        }
    }    
}

import Foundation
import NetworkingKitInterface

extension Array where Element == QueryItem {
    func toURLQueryItems() -> [URLQueryItem] {
        map { queryItem -> URLQueryItem in
            URLQueryItem(name: queryItem.name, value: queryItem.value)
        }
    }
}

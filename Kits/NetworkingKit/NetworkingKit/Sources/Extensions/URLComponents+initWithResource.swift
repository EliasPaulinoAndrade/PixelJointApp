import Foundation
import NetworkingKitInterface

public extension URLComponents {
    init?(resource: Resource) {
        self.init(string: resource.baseURL.absoluteString)
        self.path = resource.path
        self.queryItems = resource.urlParams.toURLQueryItems()
    }
}

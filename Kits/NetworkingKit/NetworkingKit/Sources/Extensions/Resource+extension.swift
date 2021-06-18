import Foundation
import NetworkingKitInterface

public extension Resource {
    var completeURL: URL? {
        let urlComponents = URLComponents(resource: self)
        return urlComponents?.url
    }
    
    var completeRequest: URLRequest? {
        guard let url = completeURL else {
            return nil
        }
    
        return URLRequest(url: url)
    }
}


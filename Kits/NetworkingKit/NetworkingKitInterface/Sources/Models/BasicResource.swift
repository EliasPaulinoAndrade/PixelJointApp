import Foundation

public struct BasicResource: Resource {
    public let baseURL: URL
    public let path: String
    
    public var method: HTTPMethod {
        .get
    }
    
    public var urlParams: [QueryItem]
    
    public init(url: URL, path: String, urlParams: [QueryItem] = []) {
        self.baseURL = url
        self.urlParams = urlParams
        self.path = path
    }
}

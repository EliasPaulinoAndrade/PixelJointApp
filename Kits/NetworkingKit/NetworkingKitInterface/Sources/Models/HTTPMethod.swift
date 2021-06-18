import Foundation

private enum DefaultHTTPMethod: String {
    case get, post, put, delete
}

public struct HTTPMethod: Equatable {
    public let methodIdentifier: String
    
    init(_ methodIdentifier: String) {
        self.methodIdentifier = methodIdentifier
    }
    
    private init(_ defaultMethod: DefaultHTTPMethod) {
        self.methodIdentifier = defaultMethod.rawValue
    }
        
    public static let get = HTTPMethod(.get)
    public static let post = HTTPMethod(.post)
    public static let put = HTTPMethod(.put)
    public static let delete = HTTPMethod(.delete)
}

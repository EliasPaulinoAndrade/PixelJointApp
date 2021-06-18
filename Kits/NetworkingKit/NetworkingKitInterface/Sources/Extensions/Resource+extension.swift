import Foundation

public extension Resource {
    var urlParams: [QueryItem] {
        return []
    }
    
    var headerParams: [String: String]? {
        return nil
    }
    
    var bodyParams: BodyParams {
        return .nothing
    }
    
    var contentType: ContentType {
        return ContentType.jsonUTF8
    }
}

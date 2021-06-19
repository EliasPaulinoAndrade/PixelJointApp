import Foundation
import NetworkingKitInterface

enum PixelJointConstants {
    static let baseURL = URL(string: "http://pixeljoint.com")!
}

struct OnArtsListResource: Resource {
    let page: Int
    let section: ArtListSection
    
    var baseURL: URL {
        PixelJointConstants.baseURL
    }
    var path: String {
        "/pixels/new_icons.asp"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var urlParams: [QueryItem] {
        guard page > 1 else {
            return [
                QueryItem(name: "ob", value: section.identifier)
            ]
        }
        
        return [
            QueryItem(name: "pg", value: String(page))
        ]
    }
    
    var cookieAcceptPolicy: HTTPCookie.AcceptPolicy {
        .always
    }
}

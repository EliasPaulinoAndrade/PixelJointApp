import Foundation
import NetworkingKitInterface

enum PixelJointConstants {
    static let baseURL = URL(string: "http://pixeljoint.com")!
}

struct OnArtsListResource: Resource {
    let page: String
    
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
        [
            QueryItem(name: "pg", value: page)
        ]
    }
}

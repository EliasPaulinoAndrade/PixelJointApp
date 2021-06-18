import Foundation
import NetworkingKitInterface

enum PixelJointConstants {
    static let baseURL = URL(string: "http://pixeljoint.com")!
}

struct OnArtDetailResource: Resource {
    let path: String
    let page: Int
    
    var baseURL: URL {
        PixelJointConstants.baseURL
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var urlParams: [QueryItem] {
        [
            QueryItem(name: "pg", value: String(page))
        ]
    }
    
    init(path: String, page: Int = 1) {
        self.path = path
        self.page = page
    }
}

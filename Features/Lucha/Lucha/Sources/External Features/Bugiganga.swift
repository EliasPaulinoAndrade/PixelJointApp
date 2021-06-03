import Foundation
import CoreKit

public protocol BugigangaListener: AnyObject {
    func userDidFinish()
}

public protocol BugigangaBuildable {
    func makeBugiganga(listener: BugigangaListener) -> ViewableCoordinating
}

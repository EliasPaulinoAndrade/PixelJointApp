import Foundation
import CoreKit
import UIKit

public protocol BugigangaBuildable {
    func makeBugiganga(listener: BugigangaListener) -> ViewableCoordinating
}

public typealias BugigangaListener = InspectorListener

public final class BugigangaBuilder: BugigangaBuildable {
    public init() { }
    public func makeBugiganga(listener: BugigangaListener) -> ViewableCoordinating {
        InspectorBuilder().makeInspector(listener: listener)
    }
}

import UIKit

public protocol OverlapRouting {
    func push(coordinating: ViewableCoordinating)
    func push(view: UIView)
    func pop()
}

public final class OverlapRouter: OverlapRouting {
    private let overlapView: OverlapView
    
    public init(overlapView: OverlapView) {
        self.overlapView = overlapView
    }
    
    public func push(view: UIView) {
        overlapView.push(view: view)
    }
    
    public func push(coordinating: ViewableCoordinating) {
        overlapView.push(view: coordinating.viewController.view)
    }
    
    public func pop() {
        overlapView.pop()
    }
}

import Foundation
import CoreKit
import UIKit

public protocol RootBuildable {
    func makeRoot() -> ViewableCoordinating
}

public struct RootBuilder: RootBuildable {
    private let externalBuilder: RootExternalBuildable
    private let externalDepedency: RootExternalDepedencing
    
    public init(externalBuilder: RootExternalBuildable, externalDepedency: RootExternalDepedencing) {
        self.externalBuilder = externalBuilder
        self.externalDepedency = externalDepedency
    }
    
    public func makeRoot() -> ViewableCoordinating {
        OnAppStartBuilder(externalBuilder: externalBuilder, externalDepedency: externalDepedency).makeOnAppStart()
    }
}

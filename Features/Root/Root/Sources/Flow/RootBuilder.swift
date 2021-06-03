import Foundation
import CoreKit
import UIKit

public protocol RootBuildable {
    func makeRoot(view: UIViewController, externalFeaturesBuider: RootExternalBuilder) -> Coordinating
}

public final class RootBuilder: RootBuildable {
    public init() { }
    public func makeRoot(view: UIViewController, externalFeaturesBuider: RootExternalBuilder) -> Coordinating {
        HasStartedBuilder(view: view, externalFeaturesBuider: externalFeaturesBuider).makeHasStarted()
    }
}

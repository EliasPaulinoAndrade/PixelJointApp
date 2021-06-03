import Foundation
import CoreKit
import UIKit

public protocol LuchaBuildable {
    func makeLucha(externalFeaturesBuider: LuchaExternalBuildable) -> Coordinating
}

public final class LuchaBuilder: LuchaBuildable {
    private let view: UIViewController
                
    public init(view: UIViewController) {
        self.view = view
    }
    
    public func makeLucha(externalFeaturesBuider: LuchaExternalBuildable) -> Coordinating {
        return LogicalBuilder(view: view, externalFeaturesBuider: externalFeaturesBuider).makeLogical()
    }
}

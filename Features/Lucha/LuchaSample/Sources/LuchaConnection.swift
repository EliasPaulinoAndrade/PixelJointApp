import Foundation
import CoreKit
import Lucha
import UIKit

final class LuchaConnection: ConnectionCoodinator {
    init(luchaBuilder: LuchaBuildable) {
        super.init()
        attach(luchaBuilder.makeLucha(externalFeaturesBuider: self))
    }
}

extension LuchaConnection: BugigangaBuildable {
    func makeBugiganga(listener: BugigangaListener) -> ViewableCoordinating {
        ViewableCoordinator.empty(title: "Bugiganga")
    }
}

import Foundation
import CoreKit
import Lucha
import UIKit
import Bugiganga

final class LuchaConnection: ConnectionCoodinator {
    init(luchaBuilder: LuchaBuildable) {
        super.init()
        attach(luchaBuilder.makeLucha(externalFeaturesBuider: self))
    }
}

extension LuchaConnection: Lucha.BugigangaBuildable {
    func makeBugiganga(listener: Lucha.BugigangaListener) -> ViewableCoordinating {
        BugigangaBuilder().makeBugiganga(listener: self)
//        ViewableCoordinator.empty(title: "Bugiganga")
    }
}

extension LuchaConnection: Bugiganga.BugigangaListener {
    func userDidFinish() {
        
    }
}

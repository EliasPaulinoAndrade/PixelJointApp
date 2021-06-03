import Foundation
import CoreKit
import Lucha
import Bugiganga
import UIKit

final class LuchaConnection: ConnectionCoodinator {
    private let bugigangaConnectionBuilder: BugigangaConnectionBuilder
    private var bugigangaListener: Lucha.BugigangaListener?
    
    init(luchaBuilder: LuchaBuildable,
         bugigangaConnectionBuilder: BugigangaConnectionBuilder,
         viewController: UIViewController) {
        
        self.bugigangaConnectionBuilder = bugigangaConnectionBuilder
        super.init()
        attach(luchaBuilder.makeLucha(view: viewController, externalFeaturesBuider: self))
    }
}

extension LuchaConnection: Lucha.BugigangaBuildable {
    func makeBugiganga(listener: Lucha.BugigangaListener) -> ViewableCoordinating {
        self.bugigangaListener = listener
        return bugigangaConnectionBuilder.makeBugigangaConnection(bugigangaListener: self)
    }
}

extension LuchaConnection: Bugiganga.BugigangaListener {
    func userDidFinish() {
        bugigangaListener?.userDidFinish()
    }
}

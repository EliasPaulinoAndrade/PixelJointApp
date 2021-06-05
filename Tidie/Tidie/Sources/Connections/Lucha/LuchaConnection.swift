import Foundation
import CoreKit
import Lucha
import Bugiganga
import UIKit
import Pucca
import PuccaInterface

final class LuchaConnection: ConnectionCoodinator {
    private let bugigangaConnectionBuilder: BugigangaConnectionBuilder
    private var bugigangaListener: Lucha.BugigangaListener?
    
    init(luchaBuilder: LuchaBuildable,
         bugigangaConnectionBuilder: BugigangaConnectionBuilder) {
        
        self.bugigangaConnectionBuilder = bugigangaConnectionBuilder
        super.init()
        attach(luchaBuilder.makeLucha(externalFeaturesBuider: self))
    }
}

extension LuchaConnection: LuchaExternalBuildable {
    func makeBugiganga(listener: Lucha.BugigangaListener) -> ViewableCoordinating {
        self.bugigangaListener = listener
        return bugigangaConnectionBuilder.makeBugigangaConnection(bugigangaListener: self)
    }
    
    func makePucca(listener: PuccaListener) -> ViewableCoordinating {
        PuccaBuilderProxy().makePucca(listener: listener)
    }
}

extension LuchaConnection: Bugiganga.BugigangaListener {
    func userDidFinish() {
        bugigangaListener?.userDidFinish()
    }
}

import Foundation
import CoreKit
import Bugiganga
import UIKit

final class BugigangaConnection: ViewableConnectionCoodinator {
    private let bugigangScene: ViewableCoordinating
    
    init(bugigangaBuilder: BugigangaBuildable, bugigangaListener: BugigangaListener) {
        self.bugigangScene = bugigangaBuilder.makeBugiganga(listener: bugigangaListener)
        
        super.init(viewController: bugigangScene.viewController)
    }
}

import Foundation
import CoreKit
import Bugiganga
import UIKit

final class BugigangaConnection: ViewableConnectionCoodinator {
    private let bugigangaListener: ConnectionBugigangaListener
    private let bugigangScene: ViewableCoordinating
    
    init(bugigangaBuilder: BugigangaBuildable) {
        let bugigangaListener = ConnectionBugigangaListener()
        
        self.bugigangaListener = bugigangaListener
        self.bugigangScene = bugigangaBuilder.makeBugiganga(listener: bugigangaListener)
        
        super.init(viewController: bugigangScene.viewController)
    }
}

private final class ConnectionBugigangaListener: BugigangaListener {
    func userDidFinish() {
        print("BugigangaListener - userDidFinish")
    }
}

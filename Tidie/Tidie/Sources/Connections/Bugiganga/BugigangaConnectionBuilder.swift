import Foundation
import Bugiganga

final class BugigangaConnectionBuilder {
    func makeBugigangaConnection(bugigangaListener: BugigangaListener) -> BugigangaConnection {
        BugigangaConnection(
            bugigangaBuilder: BugigangaBuilder(),
            bugigangaListener: bugigangaListener
        )
    }
}

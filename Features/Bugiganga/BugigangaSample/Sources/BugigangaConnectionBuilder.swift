import Foundation
import Bugiganga

final class BugigangaConnectionBuilder {
    func makeBugigangaConnection() -> BugigangaConnection {
        BugigangaConnection(bugigangaBuilder: BugigangaBuilder())
    }
}

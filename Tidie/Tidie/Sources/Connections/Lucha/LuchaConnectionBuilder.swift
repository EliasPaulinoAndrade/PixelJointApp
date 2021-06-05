import UIKit
import Lucha

final class LuchaConnectionBuilder {
    func makeLuchaConnection(viewController: UIViewController) -> LuchaConnection {
        LuchaConnection(
            luchaBuilder: LuchaBuilder(view: viewController),
            bugigangaConnectionBuilder: BugigangaConnectionBuilder()
        )
    }
}

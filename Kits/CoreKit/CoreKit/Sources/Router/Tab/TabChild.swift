import UIKit
import SwiftUI

struct TabChild: Identifiable {
    // swiftlint:disable:next identifier_name
    let id: String
    let view: TabChildViewController
}

struct TabChildViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

import SwiftUI
import UIKit

public protocol TabRouterDelegate: AnyObject {
    func userDidChangeTab(originalIdentifier: String, targetIdentifier: String)
}

public class TabRouter<Style: TabViewStyle>: TabRouting {
    let tabViewController: TabViewController<Style>
    public weak var delegate: TabRouterDelegate?
    
    public init(tabViewController: TabViewController<Style>) {
        self.tabViewController = tabViewController
        
        tabViewController.onUserChangeTab = { [weak self] in
            self?.delegate?.userDidChangeTab(originalIdentifier: $0, targetIdentifier: $1)
        }
    }
    
    public func add(coordinator: ViewableCoordinating, identifier: String) {
        add(viewController: coordinator.viewController, identifier: identifier)
    }
    
    public func remove(coordinator: ViewableCoordinating) {
        remove(viewController: coordinator.viewController)
    }
    
    public func add(viewController: UIViewController, identifier: String) {
        tabViewController.add(viewController: viewController, identifier: identifier)
    }
    
    public func remove(viewController: UIViewController) {
        tabViewController.remove(viewController: viewController)
    }
    
    public func changeToTab(with identifier: String) {
        tabViewController.changeToSection(with: identifier)
    }
}

import UIKit

public protocol Coordinating: AnyObject {
    var coordinators: [Coordinating] { get set }
    
    func attach(_ composable: Coordinating)
    func deattach(_ composables: [Coordinating])
    func deattach(_ composable: Coordinating)
    func deattach<ComposableType>(type: ComposableType.Type)
    func deattachLast()
    func deattachAll()
}

public extension Coordinating {
    func attach(_ composable: Coordinating) {
        coordinators.append(composable)
    }
    
    func deattach(_ composables: [Coordinating]) {
        composables.forEach(deattach)
    }
    
    func deattach(_ composable: Coordinating) {
        coordinators.removeAll {
            composable === $0
        }
    }
    
    func deattach<ComposableType>(type: ComposableType.Type) {
        coordinators.removeAll {
            $0 is ComposableType
        }
    }
    
    func deattachLast() {
        guard let lastCoordinator = coordinators.last else {
            return
        }
        
        deattach(lastCoordinator)
    }
    
    func deattachAll() {
        coordinators.forEach(deattach)
    }
}

public protocol InteractableCoordinating {
    var interactor: Interacting { get }
}

open class Coordinator: Coordinating, InteractableCoordinating {
    public var coordinators: [Coordinating] = []
    public let interactor: Interacting
    
    public init(interactor: Interacting) {
        self.interactor = interactor
    }
    
    public func attach(_ composable: Coordinating) {
        coordinators.append(composable)
        
        guard let childInteractor = composable as? InteractableCoordinating else { return }
        childInteractor.interactor.didStart()
    }
}

public protocol ViewableCoordinating: Coordinating {
    var viewController: UIViewController { get }
}

open class ViewableCoordinator: Coordinator, ViewableCoordinating {
    public let viewController: UIViewController
    
    public init(viewController: UIViewController, interactor: Interacting) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }
    
    public static func empty(title: String) -> ViewableCoordinator {
        let emptyViewController = UIViewController()
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        emptyViewController.view = titleLabel
        emptyViewController.view.backgroundColor = .gray
        return ViewableCoordinator(viewController: emptyViewController, interactor: EmptyInteractor())
    }
    
    public static func empty(viewController: UIViewController) -> ViewableCoordinator {
        return ViewableCoordinator(viewController: viewController, interactor: EmptyInteractor())
    }
    
    private struct EmptyInteractor: Interacting { }
}


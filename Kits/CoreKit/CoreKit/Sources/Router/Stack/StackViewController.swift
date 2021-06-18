import UIKit

public final class StackViewController: UIViewController {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        
        return stackView
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public override func loadView() {
        view = stackView
    }
    
    func removeComponent(viewController: UIViewController) {
        stackView.removeArrangedSubview(viewController.view)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
        viewController.didMove(toParent: nil)
    }
    
    func addComponent(_ viewController: UIViewController, height: CGFloat? = nil, priority: UILayoutPriority? = nil) {
        stackView.addArrangedSubview(viewController.view)
        addChild(viewController)
        viewController.didMove(toParent: self)
        
        if let verticalPriority = priority {
            viewController.view.setContentCompressionResistancePriority(verticalPriority, for: .vertical)
        }
        
        guard let fixedHeight = height else {
            return
        }
        
        NSLayoutConstraint.activate([
            viewController.view.heightAnchor.constraint(equalToConstant: fixedHeight)
        ])
    }
}

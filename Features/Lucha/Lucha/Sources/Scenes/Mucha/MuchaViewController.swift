import UIKit
import CoreKit

protocol MuchaViewable: AnyObject {
    // Add methods that presenter should call
    func showTitle(_ title: String)
    func showImage(_ image: UIImage?)
    func showError(_ message: String)
}

final class MuchaViewController: UIViewController {
    weak var interactor: MuchaInteracting?
    
    private lazy var fighterImageView: UIImageView = {
        let fighterImageView = UIImageView()
        
        fighterImageView.contentMode = .scaleAspectFit
        fighterImageView.isUserInteractionEnabled = true
        fighterImageView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(userTappedImage))
        )
        
        return fighterImageView
    }()
    
    private lazy var reloadButton: UIButton = {
        let reloadButton = UIButton(type: .system)
        
        reloadButton.tintColor = .orange
        reloadButton.setImage(UIImage(systemName: "arrow.up.arrow.down.circle"), for: .normal)
        reloadButton.addTarget(self, action: #selector(userTappedReload), for: .touchUpInside)
        
        return reloadButton
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fighterImageView, reloadButton])
        
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func loadView() {
        view = stackView
    }
    
    @objc private func userTappedImage() {
        interactor?.selectedItem()
    }
    
    @objc private func userTappedReload() {
        interactor?.getFighter()
    }
}

extension MuchaViewController: ViewCodable {
    func addConstraints() {
        NSLayoutConstraint.activate([
            reloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureView() {
        view.backgroundColor = .black
    }
}

extension MuchaViewController: MuchaViewable {
    // MuchaViewable methods
    
    func showTitle(_ title: String) {
        self.title = title
    }
    
    func showImage(_ image: UIImage?) {
        fighterImageView.image = image
    }
    
    func showError(_ message: String) {
        interactor?.openError(with: message)
    }
}

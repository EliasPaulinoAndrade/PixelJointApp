import UIKit

protocol BannerViewable: AnyObject {
    // Add methods that presenter should call
    func showImage(_ image: UIImage?)
}

final class BannerViewController: UIViewController {
    weak var interactor: BannerInteracting?
    private let bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        
        bannerImageView.contentMode = .scaleAspectFill
        
        return bannerImageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
    
    override func loadView() {
        view = bannerImageView
    }
}

extension BannerViewController: BannerViewable {
    // BannerViewable methods
    
    func showImage(_ image: UIImage?) {
        bannerImageView.image = image
    }
}

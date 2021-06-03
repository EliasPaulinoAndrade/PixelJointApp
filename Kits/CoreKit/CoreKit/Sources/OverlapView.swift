import UIKit

public class OverlapView: UIView {
    func push(view: UIView) {
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func pop() {
        subviews.last?.removeFromSuperview()
    }
}

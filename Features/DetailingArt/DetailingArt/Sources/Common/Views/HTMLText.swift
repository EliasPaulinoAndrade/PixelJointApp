import Foundation
import SwiftUI

struct HTMLText: UIViewRepresentable {
    let html: String
    let font: UIFont
    let color: UIColor
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let htmlLabel = UILabel()
    
        htmlLabel.numberOfLines = 0
        htmlLabel.lineBreakMode = .byWordWrapping
        htmlLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        htmlLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        htmlLabel.setContentHuggingPriority(.required, for: .vertical)
    
        return htmlLabel
    }
    
    func updateUIView(_ htmlLabel: UILabel, context: Context) {
        guard let htmlData = html.data(using: .utf8) else {
            return
        }
        DispatchQueue.main.async {
            guard let attributedString = try? NSAttributedString(
                        data: htmlData,
                        options: [.documentType: NSAttributedString.DocumentType.html],
                        documentAttributes: nil
                  ) else {
                return
            }
            
            htmlLabel.attributedText = attributedString
            htmlLabel.font = font
            htmlLabel.textColor = color
        }
    }
}

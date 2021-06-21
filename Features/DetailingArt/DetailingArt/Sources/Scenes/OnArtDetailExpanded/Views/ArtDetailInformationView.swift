import SwiftUI
import UIToolKit

struct ArtDetailInformationView: View {
    let artDetail: Viewable.ArtDetail
    let onUserNavigateAction: ((URL) -> Void)?
    
    @State var webViewHeight: CGFloat = .zero

    var body: some View {
        Group {
            Text(artDetail.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(DetailingArtStrings.by(artDetail.author))
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
            WebView(
                text: artDetail.description,
                textColor: UIToolKitAsset.text.color,
                linkColor: UIToolKitAsset.link.color,
                font: .preferredFont(forTextStyle: .subheadline)
            ).onUserNavigate { _, url in
                onUserNavigateAction?(url)
                return .allow
            }
            ArtDetailAccessoryView(acessories: artDetail.acessories)
        }.foregroundColor(Color(UIToolKitAsset.text.color))
    }
}

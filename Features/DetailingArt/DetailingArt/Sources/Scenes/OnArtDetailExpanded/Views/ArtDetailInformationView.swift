import SwiftUI
import UIToolKit

struct ArtDetailInformationView: View {
    let artDetail: Viewable.ArtDetail

    var body: some View {
        Group {
            Text(artDetail.title)
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(DetailingArtStrings.by(artDetail.author))
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
            HTMLText(
                html: artDetail.description,
                font: .preferredFont(forTextStyle: .subheadline),
                color: UIToolKitAsset.text.color
            )
            ArtDetailAccessoryView(acessories: artDetail.acessories)
        }.foregroundColor(Color(UIToolKitAsset.text.color))
    }
}

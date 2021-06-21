import SwiftUI
import UIToolKit
import NetworkingKitInterface
import SDWebImageSwiftUI

private enum Constant {
    static let itemSize: CGFloat = 100
}

struct PixelArtView: View {
    let art: OnArtsListView.ViewableArt
    let imageProvider: AnyProvider<(data: Data, url: URL)>

    var body: some View {
        VStack {
            AsyncImage(resource: art.resource, provider: imageProvider,
                imageProvider: { image, _, url in
                    imageProvider(for: image, url: url)
                },
                placeHolderProvider: {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(ProgressView())
                        .frame(width: Constant.itemSize, height: Constant.itemSize)
                }
            ).frame(maxWidth: .infinity)
             .aspectRatio(1, contentMode: .fill)
             .background(Color(UIToolKitAsset.background.color.withAlphaComponent(0.5)))
            Text(art.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(UIToolKitAsset.text.color))
                .frame(maxHeight: .infinity, alignment: .top)
                .font(.footnote)
                .frame(height: 40)
        }
    }
    
    @ViewBuilder
    private func imageProvider(for image: UIImage, url: URL) -> some View {
        let isBigImage = image.size.width > Constant.itemSize ||
                         image.size.height > Constant.itemSize
        if isBigImage {
            WebImage(url: url)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            WebImage(url: url)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

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
        VStack(spacing: Spacing.base0.value) {
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
            ).frame(width: Constant.itemSize, height: Constant.itemSize)
             .aspectRatio(1, contentMode: .fill)
             .background(
                Color(Colors
                    .darkBackground.color
                    .withAlphaComponent(0.2)
                )
             )
            Text(art.title)
                .padding(Spacing.base2.value)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(UIToolKitAsset.Assets.text.color))
                .frame(height: 50)
                .frame(maxWidth: .infinity, alignment: .top)
                .font(.footnote.weight(.semibold))
                .stylized(RoundedViewStyle(corners: [.bottomLeft, .bottomRight]))
        }.frame(width: Constant.itemSize)
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

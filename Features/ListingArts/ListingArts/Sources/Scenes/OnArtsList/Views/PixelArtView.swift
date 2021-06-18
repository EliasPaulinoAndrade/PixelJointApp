import SwiftUI
import UIToolKit
import NetworkingKitInterface
import NukeUI

private enum Constant {
    static let itemSize: CGFloat = 100
}

struct PixelArtView: View {
    let art: ViewableArt
    let imageProvider: AnyProvider<Data>

    var body: some View {
        VStack {
            AsyncImage(resource: art.resource, provider: imageProvider,
                imageProvider: imageProvider,
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
    private func imageProvider(for image: UIImage) -> some View {
        let isBigImage = image.size.width > Constant.itemSize ||
                         image.size.height > Constant.itemSize
        if isBigImage {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Image(uiImage: image)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

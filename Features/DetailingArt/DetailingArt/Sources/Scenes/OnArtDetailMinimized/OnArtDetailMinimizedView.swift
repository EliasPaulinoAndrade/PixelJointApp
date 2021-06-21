import SwiftUI
import UIToolKit
import NetworkingKitInterface

extension OnArtDetailMinimizedView {
    struct MinimizedArtDetail {
        let title: String
        let author: String
        var imageResource: AsyncImageResource
    }
}

private enum Constant {
    static let imageSize: CGFloat = 50
    static let minimumSize: CGFloat = 50
}

struct OnArtDetailMinimizedView: View {
    private typealias Strings = DetailingArtStrings.OnArtDetailMinimized
    
    @ObservedObject private var stateHolder: OnArtDetailMinimizedViewStateHolder
    private let imageProvider: AnyProvider<(data: Data, url: URL)>
    
    var body: some View {
        HStack {
            if let artDetail = stateHolder.artDetail {
                Button(
                    action: {
                        stateHolder.interactor?.maximizeSelected()
                    },
                    label: {
                        artDetailView(artDetail: artDetail)
                    }
                )
                .foregroundColor(Color(UIToolKitAsset.link.color))
            } else {
                EmptyStateView(
                    isLoading: $stateHolder.isLoading,
                    isShowingError: $stateHolder.isShowingError,
                    errorTitle: Strings.couldNotLoadArt,
                    retryTitle: Strings.tapToRetry,
                    mustShowImage: false,
                    retryAction: stateHolder.interactor?.retrySelected
                ).frame(minHeight: Constant.minimumSize)
            }
        }.background(Color(UIToolKitAsset.extraDark.color))
    }
    
    init(stateHolder: OnArtDetailMinimizedViewStateHolder, imageProvider: AnyProvider<(data: Data, url: URL)>) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
    }
    
    private func artDetailView(artDetail: OnArtDetailMinimizedView.MinimizedArtDetail) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "chevron.up")
            AsyncImage(
                resource: artDetail.imageResource,
                provider: imageProvider,
                imageProvider: { image, _, _ in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                },
                placeHolderProvider: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            ).frame(width: Constant.imageSize, height: Constant.imageSize)
            
            VStack {
                Text(artDetail.title)
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(DetailingArtStrings.by(artDetail.author))
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }.padding(8)
    }
}

import UIKit
import SwiftUI
import NetworkingKitInterface
import UIToolKit

extension OnArtsListView {
    struct ViewableArt: Identifiable {
        let id: String
        let resource: AsyncImageResource
        let title: String
    }
}

private enum Constant {
    static let itemSize: CGFloat = 100
}

struct OnArtsListView: View {
    private typealias Strings = ListingArtsStrings.OnArtsList
    
    @ObservedObject private var stateHolder: OnArtsListViewStateHolder
    private let imageProvider: AnyProvider<(data: Data, url: URL)>
    private let columns = [GridItem(.adaptive(minimum: Constant.itemSize, maximum: Constant.itemSize))]
    
    var body: some View {
        Group {
            if stateHolder.arts.isEmpty {
                EmptyStateView(
                    isLoading: $stateHolder.isLoading,
                    isShowingError: $stateHolder.isShowingError,
                    errorTitle: Strings.couldNotLoad,
                    retryTitle: Strings.tapToRetry,
                    retryAction: stateHolder.interactor?.retryFirstPageSelected
                )
            } else {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(stateHolder.arts) { art in
                                PixelArtView(art: art, imageProvider: imageProvider)
                                    .onTapGesture {
                                       stateHolder.interactor?.artSelected(identifier: art.id)
                                    }
                                    .onAppear {
                                       stateHolder.interactor?.artDidAppear(identifier: art.id)
                                    }
                            }
                        }

                        FooterEmptyStateView(
                            isLoading: $stateHolder.isFooterLoading,
                            isShowingError: $stateHolder.isFooterShowingError,
                            hasNoMoreContent: $stateHolder.hasNoMorePages,
                            errorTitle: Strings.couldNotLoadMore,
                            retryTitle: Strings.tapToRetry,
                            noContentTitle: Strings.noMoreArts,
                            retryAction: stateHolder.interactor?.retrySelected
                        ).padding(.all, 8)
                    }
                }
            }
        }.background(Color(UIToolKitAsset.darkBackground.color))
    }
    
    init(stateHolder: OnArtsListViewStateHolder, imageProvider: AnyProvider<(data: Data, url: URL)>) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
    }
}


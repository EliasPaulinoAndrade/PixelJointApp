import UIKit
import SwiftUI
import NetworkingKitInterface
import UIToolKit

struct ViewableArt: Identifiable {
    // swiftlint:disable:next identifier_name
    let id: String
    let resource: AsyncImageResource
    let title: String
}

private enum Constant {
    static let itemSize: CGFloat = 100
}

struct OnArtsListView: View {
    private typealias Strings = ListingArtsStrings.OnArtsList
    
    @ObservedObject private var stateHolder: OnArtsListViewStateHolder
    private let imageProvider: AnyProvider<Data>
    private let columns = [GridItem(.adaptive(minimum: Constant.itemSize, maximum: Constant.itemSize))]
    
    var body: some View {
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
                    LazyVGrid(columns: columns, spacing: 5) {
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
    }
    
    init(stateHolder: OnArtsListViewStateHolder, imageProvider: AnyProvider<Data>) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
    }
}


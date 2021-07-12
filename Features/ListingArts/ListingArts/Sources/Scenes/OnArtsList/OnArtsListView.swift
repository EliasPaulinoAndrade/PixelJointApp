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
    static let itemWidth: CGFloat = 100
    static let itemHeight: CGFloat = 150
}

struct OnArtsListView: View {
    private typealias Strings = ListingArtsStrings.OnArtsList
    
    @ObservedObject private var stateHolder: OnArtsListViewStateHolder
    private let imageProvider: AnyProvider<(data: Data, url: URL)>
    private let columns = [
        GridItem(
            .adaptive(minimum: Constant.itemWidth, maximum: Constant.itemWidth),
            spacing: Spacing.base5.value
        )
    ]
    private let isVertical: Bool
    
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
                ScrollView(isVertical ? .vertical : .horizontal) {
                    gridStack {
                        itemsGrid {
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
                            noContentTitle: .constant(Strings.noMoreArts),
                            retryAction: stateHolder.interactor?.retrySelected
                        ).padding(.all, Spacing.base3.value)
                    }
                }
            }
        }.background(Color(Colors.background2.color))
    }
    
    init(stateHolder: OnArtsListViewStateHolder,
         imageProvider: AnyProvider<(data: Data, url: URL)>,
         isVertical: Bool) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
        self.isVertical = isVertical
    }
    
    @ViewBuilder
    private func gridStack<ViewType: View>(@ViewBuilder viewBuilder: () -> ViewType) -> some View {
        if isVertical {
            VStack(content: viewBuilder)
        } else {
            HStack(content: viewBuilder)
        }
    }
    
    @ViewBuilder
    private func itemsGrid<ViewType: View>(viewBuilder: () -> ViewType) -> some View {
        if isVertical {
            let columnItem = GridItem(
                .adaptive(minimum: Constant.itemWidth, maximum: Constant.itemWidth),
                spacing: Spacing.base5.value
            )
            LazyVGrid(
                columns: [columnItem],
                spacing: Spacing.base4.value,
                content: viewBuilder
            )
        } else {
            let rowItem = GridItem(
                .adaptive(minimum: Constant.itemHeight, maximum: Constant.itemHeight),
                spacing: Spacing.base5.value
            )
            LazyHGrid(
                rows: [rowItem],
                spacing: Spacing.base4.value,
                content: viewBuilder
            )
        }
    }
}

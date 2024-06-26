import UIKit
import SwiftUI
import NetworkingKitInterface
import UIToolKit

enum Viewable {
    struct Accessory: Identifiable {
        let id: String
        let count: String
        let image: UIImage
    }
        
    struct ArtDetail {
        let title: String
        let author: String
        let description: String
        let image: AsyncImageResource
        let acessories: [Accessory]
    }

    struct Comment: Identifiable {
        var id: String
        let author: String
        let message: String
        let image: AsyncImageResource
    }
}

struct OnArtDetailExpandedView: View {
    private typealias Strings = DetailingArtStrings.OnArtDetailExpanded
    
    @ObservedObject private var stateHolder: OnArtDetailExpandedViewStateHolder
    private let imageProvider: AnyProvider<(data: Data, url: URL)>
    
    var body: some View {
        ZStack {
            if let artDetail = stateHolder.artDetail {
                ZStack {
                    ScrollView {
                        LazyVStack {
                            ArtDetailImage(imageResource: artDetail.image, imageProvider: imageProvider)
                            fullSizeButton()
                                .foregroundColor(Color(UIToolKitAsset.link.color))
                                .onDisappear {
                                    withAnimation(.easeOut) {
                                        stateHolder.isFullSizeButtonOnHeader = true
                                    }
                                }
                                .onAppear {
                                    withAnimation(.easeIn) {
                                        stateHolder.isFullSizeButtonOnHeader = false
                                    }
                                }
                            ArtDetailInformationView(
                                artDetail: artDetail,
                                onUserNavigateAction: stateHolder.interactor?.linkSelected
                            )
                            CommentsListView(comments: stateHolder.comments, imageProvider: imageProvider)
                                .onCommentAppear(perform: stateHolder.interactor?.commentDidAppear)
                            FooterEmptyStateView(
                                isLoading: $stateHolder.isShowingFooterLoading,
                                isShowingError: $stateHolder.isShowingFooterError,
                                hasNoMoreContent: $stateHolder.hasNoMorePages,
                                errorTitle: Strings.couldNotLoadComments,
                                retryTitle: Strings.tapToRetry,
                                noContentTitle: $stateHolder.hasNoMorePagesTitle,
                                retryAction: stateHolder.interactor?.retryLoadCommentsSelected
                            )
                            Spacer()
                        }.padding([.horizontal, .bottom], 8)
                         .padding(.top, 80)
                    }
                    VStack {
                        headerView(artTitle: artDetail.title)
                            .foregroundColor(Color(UIToolKitAsset.link.color))
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(BlurView())
                        if stateHolder.isFullSizeButtonOnHeader {
                            zoomButton()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .zIndex(-1)
                        }
                        Spacer()
                    }
                }
            } else {
                EmptyStateView(
                    isLoading: $stateHolder.isLoading,
                    isShowingError: $stateHolder.isShowingError,
                    errorTitle: Strings.couldNotLoadArt,
                    retryTitle: Strings.tapToRetry,
                    retryAction: stateHolder.interactor?.retrySelected
                )
            }
        }.background(Color(UIToolKitAsset.darkBackground.color))
         .ignoresSafeArea()
    }
    
    init(stateHolder: OnArtDetailExpandedViewStateHolder, imageProvider: AnyProvider<(data: Data, url: URL)>) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
    }
    
    private func zoomButton() -> some View {
        Button(
            action: {
                stateHolder.interactor?.fullSizeSelected()
            },
            label: {
                ZStack {
                    Circle()
                        .fill(Color(UIToolKitAsset.link.color))
                    Image(systemName: "plus.magnifyingglass")
                        .resizable()
                        .padding(12)
                }.frame(width: 50, height: 50)
            }
        ).padding(8)
         .shadow(radius: 10)
         .foregroundColor(Color(UIToolKitAsset.darkBackground.color))
         .transition(
            .move(edge: .top)
            .combined(with: .offset( .init(width: 0, height: -50)))
         )
    }
    
    private func fullSizeButton() -> some View {
        Button(
            action: {
                stateHolder.interactor?.fullSizeSelected()
            },
            label: {
                HStack {
                    Spacer().overlay(
                        Image(systemName: "plus.magnifyingglass")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    )
                    Text(Strings.seeFullSize)
                    Spacer()
                }
            }
        )
    }
    
    private func headerView(artTitle: String) -> some View {
        Button(
            action: {
                stateHolder.interactor?.minimizeButtonTapped()
            },
            label: {
                HStack(spacing: 8) {
                    Spacer().overlay(
                        Image(systemName: "chevron.down")
                    )
                    Text(artTitle)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        )
    }
}

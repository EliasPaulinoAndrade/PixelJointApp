import Foundation
import CoreKit
import UIToolKit
import UIKit

protocol OnArtDetailExpandedPresenting: AnyObject {
    func presentArtDetail(_ artDetail: PixelArtDetail)
    func presentComments(_ comments: [Comment])
    func presentError()
    func presentFooterError()
    func presentLoading()
    func presentFooterLoading()
    func hideError()
    func hideLoading()
    func hideFooterError()
    func hideFooterLoading()
    func presentNoMorePages()
    func presentNoComments()
}

final class OnArtDetailExpandedPresenter {
    private typealias Strings = DetailingArtStrings.OnArtDetailExpanded
    
    private let view: OnArtDetailExpandedViewable
    
    init(view: OnArtDetailExpandedViewable) {
        self.view = view
    }
    
    private func getArtAcessories(_ art: PixelArtDetail) -> [Viewable.Accessory] {
        let acessoriesInfo = [
            (art.commentsCount, UIImage(systemName: "bubble.right.fill")),
            (art.favoritesCount, UIImage(systemName: "heart.fill"))
        ]
        
        return acessoriesInfo.compactMap { count, image -> Viewable.Accessory? in
            guard let count = count,
                  let image = image else {
                return nil
            }
            return Viewable.Accessory(id: UUID().uuidString, count: count, image: image)
        }
    }
}

extension OnArtDetailExpandedPresenter: OnArtDetailExpandedPresenting {
    func presentNoComments() {
        view.showNoMoreContent(text: Strings.noComments)
    }
    
    func presentNoMorePages() {
        view.showNoMoreContent(text: Strings.noMoreComments)
    }
    
    func presentFooterLoading() {
        view.isShowingFooterLoading = true
    }
    
    func presentFooterError() {
        view.isShowingFooterError = true
    }
    
    func presentError() {
        view.isShowingError = true
    }
    
    func presentLoading() {
        view.isLoading = true
    }
    
    func hideFooterLoading() {
        view.isShowingFooterLoading = false
    }
    
    func hideFooterError() {
        view.isShowingFooterError = false
    }
    
    func hideError() {
        view.isShowingError = false
    }
    
    func hideLoading() {
        view.isLoading = false
    }
    
    func presentArtDetail(_ artDetail: PixelArtDetail) {
        let artImageResource = AsyncImageResource(baseURL: PixelJointConstants.baseURL, path: artDetail.detailImage)
        let viewableDetail = Viewable.ArtDetail(
            title: artDetail.title,
            author: artDetail.authorName,
            description: artDetail.description,
            image: artImageResource,
            acessories: getArtAcessories(artDetail)
        )
    
        view.showArtDetail(viewableDetail)
    }
    
    func presentComments(_ comments: [Comment]) {
        let viewableComments = comments.map { comment in
            Viewable.Comment(
                id: comment.identifier,
                author: comment.author,
                message: comment.message,
                image: AsyncImageResource(baseURL: PixelJointConstants.baseURL, path: comment.avatarImage)
            )
        }
        view.showComments(viewableComments)
    }
}

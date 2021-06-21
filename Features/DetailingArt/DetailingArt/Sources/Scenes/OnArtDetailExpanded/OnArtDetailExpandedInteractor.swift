import Foundation
import CoreKit
import DetailingArtInterface
import Combine

protocol OnArtDetailExpandedInteracting: AnyObject {
    func minimizeButtonTapped()
    func fullSizeSelected()
    func retrySelected()
    func retryLoadCommentsSelected()
    func commentDidAppear(_ commentID: String)
    func linkSelected(url: URL)
}

protocol OnArtDetailExpandedListener: AnyObject {
    func userMimnimized()
    func needRetry()
}

private enum Constant {
    static let firstPageIndex = 1
}

final class OnArtDetailExpandedInteractor: Interacting {
    typealias Log = OnArtDetailExpandedLog
    typealias Depedencies = HasHTMLLinkOpenner
    
    private let presenter: OnArtDetailExpandedPresenting
    private let service: OnArtDetailExpandedServicing
    private let artDetailPublisher: ArtDetailInfoPublisher
    private let logger: Logging
    private let depedencies: Depedencies
    private var cancellables: [AnyCancellable] = []
    private var currentArtInfo: PixelArtInfo?
    private var currentPageIndex: Int = Constant.firstPageIndex - 1
    private var currentComments: [Comment] = []
    private var currentCommentsPage: CommentPage?
    private var isFetchingNextPage = false
    
    weak var coordinator: OnArtDetailExpandedCoordinating?
    weak var listener: OnArtDetailExpandedListener?
    
    init(presenter: OnArtDetailExpandedPresenting,
         service: OnArtDetailExpandedServicing,
         artDetailPublisher: ArtDetailInfoPublisher,
         logger: Logging,
         depedencies: Depedencies
    ) {
        self.presenter = presenter
        self.artDetailPublisher = artDetailPublisher
        self.logger = logger
        self.service = service
        self.depedencies = depedencies
    }
    
    func didStart() {
        presenter.presentLoading()
        artDetailPublisher
            .sink { [weak self] result in
                self?.handleArtDetail(result: result)
            }
            .store(in: &cancellables)
    }
    
    private func handleArtDetail(result: Result<PixelArtInfo, Error>) {
        switch result {
        case .success(let artInfo):
            updateState(artInfo: artInfo)
            resetComments()
            getNextCommentsPage(artURL: artInfo.artURL)
            presenter.presentArtDetail(artInfo.art)
            presenter.hideError()
        case .failure:
            presenter.presentError()
        }
        presenter.hideLoading()
    }
 
    private func getNextCommentsPage(artURL: URL) {
        let nextCommentsPageIndex = currentPageIndex + 1
        didStartLoadingComments()
        presenter.presentFooterLoading()
        service.getComments(artURL: artURL, pageIndex: nextCommentsPageIndex) { [weak self] result in
            self?.handleComments(result: result, nextCommentsPageIndex: nextCommentsPageIndex)
        }
    }
    
    private func handleComments(result: Result<CommentPage, Error>, nextCommentsPageIndex: Int) {
        switch result {
        case .success(let commentsPage):
            updateComments(commentsPage: commentsPage, currentPageIndex: nextCommentsPageIndex)
        case .failure:
            presenter.presentFooterError()
        }
        
        presenter.hideFooterLoading()
        didEndLoadingComments()
    }
    
    private func didEndLoadingComments() {
        isFetchingNextPage = false
    }
    
    private func didStartLoadingComments() {
        isFetchingNextPage = true
    }
    
    private func resetComments() {
        currentComments = []
        currentPageIndex = Constant.firstPageIndex - 1
        currentCommentsPage = nil
        presenter.presentComments(currentComments)
    }
    
    private func updateComments(commentsPage: CommentPage, currentPageIndex: Int) {
        currentComments.append(contentsOf: commentsPage.comments)
        self.currentPageIndex = currentPageIndex
        currentCommentsPage = commentsPage
        presenter.presentComments(currentComments)
        logger.log(Log.showingPage(pageIndex: currentPageIndex), LogicalLog.message)
        
        if currentPageIndex == Constant.firstPageIndex && commentsPage.comments.isEmpty {
            presenter.presentNoComments()
        }
    }
    
    private func updateState(artInfo: PixelArtInfo) {
        self.currentArtInfo = artInfo
    }
}

extension OnArtDetailExpandedInteractor: OnArtDetailExpandedInteracting {
    func minimizeButtonTapped() {
        listener?.userMimnimized()
    }
    
    func fullSizeSelected() {
        guard let artDetail = currentArtInfo?.art else {
            return logger.log(OnArtDetailExpandedLog.fullSizeRequestedWithoutArtDetail, LogicalLog.critical)
        }
        coordinator?.openFullSizeImage(image: artDetail.detailImage, listener: self)
    }
    
    func retrySelected() {
        presenter.presentLoading()
        listener?.needRetry()
    }
    
    func retryLoadCommentsSelected() {
        guard let currentArtUrl = currentArtInfo?.artURL else {
            return logger.log(Log.retriedLoadCommentsWithNoCurrentArt, LogicalLog.critical)
        }
        presenter.hideFooterError()
        getNextCommentsPage(artURL: currentArtUrl)
    }
    
    func commentDidAppear(_ commentID: String) {
        guard let currentArtUrl = currentArtInfo?.artURL,
              let currentPage = self.currentCommentsPage else {
            return logger.log(Log.commentDidAppearWithoutNoCommentsPage, LogicalLog.critical)
        }
        
        let userDidReachLastItem = currentComments.last?.identifier == commentID
        let nextPageIndex = currentPageIndex + 1
        let hasNextPage = nextPageIndex <= currentPage.pagesTotal
        
        guard userDidReachLastItem, !isFetchingNextPage else {
            return
        }
        
        guard hasNextPage else {
            return presenter.presentNoMorePages()
        }
        
        getNextCommentsPage(artURL: currentArtUrl)
    }
    
    func linkSelected(url: URL) {
        depedencies.linkOpenned.open(link: url)
    }
}

extension OnArtDetailExpandedInteractor: OnImageFullSizeListener {
    func userFinished() {
        coordinator?.closeFullSize()
    }
}

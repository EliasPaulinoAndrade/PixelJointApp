import Foundation
import CoreKit
import ListingArtsInterface

protocol OnArtsListInteracting: AnyObject {
    func artDidAppear(identifier: String)
    func retrySelected()
    func retryFirstPageSelected()
    func artSelected(identifier: String)
}

typealias OnArtsListListener = ListingArtsListener

private enum Constant {
    static let firstPageIndex = 1
}

final class OnArtsListInteractor: Interacting {
    private typealias Log = OnArtsListLog
    
    private let presenter: OnArtsListPresenting
    private let service: OnArtsListServicing
    private let logger: Logging
    weak var coordinator: OnArtsListCoordinating?
    weak var listener: OnArtsListListener?
    
    private var currentPage: GalleryPage?
    private var currentArts: [PixelArt] = []
    private var currentTips: [PixelArtTip] = []
    private var isFetchingNextPage = false
    
    init(presenter: OnArtsListPresenting, service: OnArtsListServicing, logger: Logging) {
        self.presenter = presenter
        self.service = service
        self.logger = logger
    }
    
    func didStart() {
        fetchFirstPage()
    }
    
    private func updateState(newPage galleryPage: GalleryPage) {
        self.currentPage = galleryPage
        self.currentArts.append(contentsOf: galleryPage.gallery.pixelArts)
        self.currentTips.append(contentsOf: galleryPage.gallery.pixelArtsTips)
        logger.log(Log.showingPage(pageIndex: galleryPage.pageIndex), LogicalLog.message)
        presenter.presentArts(currentArts, tips: currentTips)
    }
    
    private func didStartLoading() {
        isFetchingNextPage = true
    }
    
    private func didStopLoading() {
        isFetchingNextPage = false
    }
    
    private func fetchFirstPage() {
        presenter.presentLoading()
        didStartLoading()
        service.getArts(page: Constant.firstPageIndex) { [weak self] result in
            self?.handleFirstPage(result: result)
        }
    }
    
    private func handleFirstPage(result: Result<GalleryPage, Error>) {
        switch result {
        case .success(let galleryPage):
            updateState(newPage: galleryPage)
            presenter.hideError()
        case .failure:
            presenter.presentError()
        }
        presenter.hideLoading()
        didStopLoading()
    }
    
    private func fetchNextPage(index nextPageIndex: Int) {
        presenter.presentFooterLoading()
        didStartLoading()
        service.getArts(page: nextPageIndex) { [weak self] result in
            self?.handleNextPage(result: result)
        }
    }
    
    private func handleNextPage(result: Result<GalleryPage, Error>) {
        switch result {
        case .success(let galleryPage):
            updateState(newPage: galleryPage)
            presenter.hideFooterError()
        case .failure:
            presenter.presentFooterError()
        }
        presenter.hideFooterLoading()
        didStopLoading()
    }
}

extension OnArtsListInteractor: OnArtsListInteracting {
    func artSelected(identifier: String) {
        guard let selectedArt = currentArts.first(where: {
            $0.identifier == identifier
        }) else {
            return logger.log(Log.nonExistentArtSelected(artIdentifier: identifier), LogicalLog.critical)
        }
        listener?.pixelArtSelected(selectedArt.link)
    }
    
    func artDidAppear(identifier: String) {
        guard let currentPage = currentPage else {
            return logger.log(Log.artDidAppearWithoutShowingPage(artIdentifier: identifier), LogicalLog.critical)
        }
        
        let userDidReachLastItem = currentPage.gallery.pixelArts.last?.identifier == identifier
        let nextPageIndex = currentPage.pageIndex + 1
        let hasNextPage = nextPageIndex <= currentPage.gallery.pagesTotal
        
        guard userDidReachLastItem, !isFetchingNextPage else {
            return
        }
        
        guard hasNextPage else {
            return presenter.presentNoMoreAlerts()
        }
        
        fetchNextPage(index: currentPage.pageIndex + 1)
    }
    
    func retrySelected() {
        guard let currentPage = currentPage else {
            return logger.log(Log.retryTappedWithoutShowingPage, LogicalLog.critical)
        }
        
        guard !isFetchingNextPage else {
            return
        }
        
        presenter.hideFooterError()
        fetchNextPage(index: currentPage.pageIndex + 1)
    }
    
    func retryFirstPageSelected() {
        fetchFirstPage()
    }
}

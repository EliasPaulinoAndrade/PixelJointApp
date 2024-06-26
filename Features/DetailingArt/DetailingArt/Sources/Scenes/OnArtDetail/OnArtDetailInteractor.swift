import Foundation
import CoreKit
import Combine
import DetailingArtInterface

typealias ArtDetailInfoPublisher = AnyPublisher<Result<PixelArtInfo, Error>, Never>

final class OnArtDetailInteractor: Interacting {
    private typealias Log = OnArtDetailLog
    typealias ArtPublisherResult = Result<PixelArtInfo, Error>
    
    private let service: OnArtDetailServicing
    private let openDetailPublisher: AnyPublisher<URL, Never>
    private let logger: Logging
    private let artDetailSubject = PassthroughSubject<ArtPublisherResult, Never>()
    private lazy var artDetailPublisher = artDetailSubject.eraseToAnyPublisher()
    private var cancellables: [AnyCancellable] = []
    private var isMinimizedDetailOpenned = false
    private var artURL: URL?
    
    weak var coordinator: OnArtDetailCoordinating?
    
    init(service: OnArtDetailServicing, openDetailPublisher: AnyPublisher<URL, Never>, logger: Logging) {
        self.service = service
        self.openDetailPublisher = openDetailPublisher
        self.logger = logger
    }
    
    func didStart() {
        listenDetailExpand()
    }
    
    private func updateArtLink(_ link: URL) {
        self.artURL = link
    }
    
    private func getArtDetail(link: URL) {
        service.getArtDetail(link: link) { [artDetailSubject] result in
            artDetailSubject.send(
                result.map { artDetail in
                    PixelArtInfo(art: artDetail, artURL: link)
                }
            )
        }
    }
    
    private func showMinimizedDetail() {
        guard !isMinimizedDetailOpenned else {
            return
        }
        
        isMinimizedDetailOpenned = true
        coordinator?.openMinimizedDetail(
            artDetail: artDetailPublisher,
            listener: self
        )
    }
    
    private func expandDetail() {
        coordinator?.openExpandedDetail(
            artDetail: artDetailPublisher,
            listener: self
        )
    }
    
    private func listenDetailExpand() {
        openDetailPublisher.sink { [weak self] artURL in
            guard let self = self else { return }
            self.showMinimizedDetail()
            self.expandDetail()
            self.updateArtLink(artURL)
            self.getArtDetail(link: artURL)
        }.store(in: &cancellables)
    }
}

extension OnArtDetailInteractor: OnArtDetailExpandedListener {
    func userMimnimized() {
        coordinator?.closeExpandedDetail()
    }
}

extension OnArtDetailInteractor: OnArtDetailMinimizedListener {
    func needRetry() {
        guard let artDetailURL = self.artURL else {
            return logger.log(Log.needRetryWithoutArtURL, LogicalLog.critical)
        }
        
        getArtDetail(link: artDetailURL)
    }
    
    func needMaximizeDetail() {
        guard let artDetailURL = self.artURL else {
            return logger.log(Log.needMaximazeWithoutArtURL, LogicalLog.critical)
        }
        expandDetail()
        getArtDetail(link: artDetailURL)
    }
}

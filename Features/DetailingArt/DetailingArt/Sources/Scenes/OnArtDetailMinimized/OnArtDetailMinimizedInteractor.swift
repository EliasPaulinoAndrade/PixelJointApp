import Foundation
import CoreKit
import Combine

protocol OnArtDetailMinimizedInteracting: AnyObject {
    func maximizeSelected()
    func retrySelected()
}

public protocol OnArtDetailMinimizedListener: AnyObject {
    func needMaximizeDetail()
    func needRetry()
}

final class OnArtDetailMinimizedInteractor: Interacting {
    private let presenter: OnArtDetailMinimizedPresenting
    weak var listener: OnArtDetailMinimizedListener?
    private let artDetailPublisher: ArtDetailInfoPublisher
    private var cancellables: [AnyCancellable] = []
    private var isShowingArt = false

    init(presenter: OnArtDetailMinimizedPresenting, artDetailPublisher: ArtDetailInfoPublisher) {
        self.presenter = presenter
        self.artDetailPublisher = artDetailPublisher
    }
    
    func didStart() {
        presenter.presentLoading()
        artDetailPublisher.sink { [weak self] result in
            self?.handleArt(result: result.map {
                $0.art
            })
        }.store(in: &cancellables)
    }
    
    private func handleArt(result: Result<PixelArtDetail, Error>) {
        switch result {
        case .success(let pixelArtDetail):
            presenter.presentArt(pixelArtDetail)
            presenter.hideError()
            isShowingArt = true
        case .failure:
            if !isShowingArt {
                presenter.presentError()
            }
        }
        presenter.hideLoading()
    }
}

extension OnArtDetailMinimizedInteractor: OnArtDetailMinimizedInteracting {
    func maximizeSelected() {
        listener?.needMaximizeDetail()
    }
    
    func retrySelected() {
        presenter.presentLoading()
        listener?.needRetry()
    }
}

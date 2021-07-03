import Foundation
import CoreKit
import ListingArtsInterface
import DetailingArtInterface
import Combine

private enum Constants: String {
    case opennedArt
}

final class OnAppStartInteractor: Interacting {
    private typealias Log = OnAppStartLog
    typealias Depedencies = HasLocalStoraging
    
    weak var coordinator: OnAppStartCoordinating?
    private var isDetailOpened = false
    private let expandDetailPublisher = PassthroughSubject<URL, Never>()
    private let depedencies: Depedencies
    private let logger: Logging
    
    init(depedencies: Depedencies, logger: Logging) {
        self.depedencies = depedencies
        self.logger = logger
    }
    
    func didStart() {
        coordinator?.openListingArts(listener: self)
        checkForOpennedDetail()
    }
    
    private func checkForOpennedDetail() {
        guard let opennedArtURLString = depedencies.storage.get(key: Constants.opennedArt.rawValue),
              let opennedArtURL = URL(string: opennedArtURLString) else {
            return logger.log(Log.opennedAppWithoutCachedPixelArt, LogicalLog.message)
        }
        pixelArtSelected(opennedArtURL)
        logger.log(Log.opennedAppWithCachedPixelArt(artLink: opennedArtURL), LogicalLog.message)
    }
}

extension OnAppStartInteractor: ListingArtsListener {
    func pixelArtSelected(_ link: URL) {
        depedencies.storage.save(string: link.absoluteString, for: Constants.opennedArt.rawValue)
        guard !isDetailOpened else {
            return expandDetailPublisher.send(link)
        }
        isDetailOpened = true
        coordinator?.openDetailingArt(
            openDetailPublisher: expandDetailPublisher.eraseToAnyPublisher()
        )
        expandDetailPublisher.send(link)
    }
}

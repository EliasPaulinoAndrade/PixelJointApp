import XCTest
@testable import DetailingArt

//sourcery: spy
extension OnArtDetailListener { }

final class OnArtDetailInteractorTests: XCTestCase {
    private let listenerSpy = OnArtDetailListenerSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailInteractorTests {
    private func makeSut() -> OnArtDetailInteractor {
        let interactor = OnArtDetailInteractor()
        interactor.listener = listenerSpy
        return interactor
    }
}

import XCTest
@testable import DetailingArt

//sourcery: spy
extension OnArtDetailMinimizedPresenting { }
//sourcery: spy
extension OnArtDetailMinimizedListener { }

final class OnArtDetailMinimizedInteractorTests: XCTestCase {
    private let presenterSpy = OnArtDetailMinimizedPresentingSpy()
    private let listenerSpy = OnArtDetailMinimizedListenerSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailMinimizedInteractorTests {
    private func makeSut() -> OnArtDetailMinimizedInteractor {
        let interactor = OnArtDetailMinimizedInteractor(presenter: presenterSpy)
        interactor.listener = listenerSpy
        return interactor
    }
}

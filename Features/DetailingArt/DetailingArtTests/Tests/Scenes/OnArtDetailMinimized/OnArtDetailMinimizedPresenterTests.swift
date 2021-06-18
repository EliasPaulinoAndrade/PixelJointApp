import XCTest
@testable import DetailingArt

//sourcery: spy
extension OnArtDetailMinimizedViewable { }

final class OnArtDetailMinimizedPresenterTests: XCTestCase {
    private let viewSpy = OnArtDetailMinimizedViewableSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailMinimizedPresenterTests {
    private func makeSut() -> OnArtDetailMinimizedPresenter {
        OnArtDetailMinimizedPresenter(view: viewSpy)
    }
}

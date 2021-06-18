import XCTest
@testable import DetailingArt

//sourcery: spy
extension OnArtDetailViewable { }

final class OnArtDetailPresenterTests: XCTestCase {
    private let viewSpy = OnArtDetailViewableSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailPresenterTests {
    private func makeSut() -> OnArtDetailPresenter {
        OnArtDetailPresenter(view: viewSpy)
    }
}

import XCTest
@testable import ListingArts

//sourcery: spy
extension OnArtsListViewable { }

final class OnArtsListPresenterTests: XCTestCase {
    private let viewSpy = OnArtsListViewableSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtsListPresenterTests {
    private func makeSut() -> OnArtsListPresenter {
        OnArtsListPresenter(view: viewSpy)
    }
}

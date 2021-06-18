import XCTest
@testable import ListingArts

//sourcery: spy
extension ListingArtsViewable { }

final class ListingArtsPresenterTests: XCTestCase {
    private let viewSpy = ListingArtsViewableSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension ListingArtsPresenterTests {
    private func makeSut() -> ListingArtsPresenter {
        ListingArtsPresenter(view: viewSpy)
    }
}

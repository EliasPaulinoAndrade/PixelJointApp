import XCTest
@testable import ListingArts

//sourcery: spy
extension ListingArtsPresenting { }

final class ListingArtsInteractorTests: XCTestCase {
    private let presenterSpy = ListingArtsPresentingSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension ListingArtsInteractorTests {
    private func makeSut() -> ListingArtsInteractor {
        let interactor = ListingArtsInteractor(presenter: presenterSpy)
        return interactor
    }
}

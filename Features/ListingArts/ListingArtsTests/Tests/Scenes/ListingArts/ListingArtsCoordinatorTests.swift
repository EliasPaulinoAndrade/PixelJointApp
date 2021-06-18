import XCTest
import TestKit
@testable import ListingArts

final class ListingArtsCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension ListingArtsCoordinatorTests {
    private func makeSut() -> ListingArtsCoordinator {
        ListingArtsCoordinator(viewController: UIViewController(), interactor: InteractingStub())
    }
}

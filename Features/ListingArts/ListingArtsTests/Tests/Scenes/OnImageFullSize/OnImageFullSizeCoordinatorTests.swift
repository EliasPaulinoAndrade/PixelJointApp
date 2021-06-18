import XCTest
import TestKit
@testable import ListingArts

final class OnImageFullSizeCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnImageFullSizeCoordinatorTests {
    private func makeSut() -> OnImageFullSizeCoordinator {
        OnImageFullSizeCoordinator(viewController: UIViewController(), interactor: InteractingStub())
    }
}

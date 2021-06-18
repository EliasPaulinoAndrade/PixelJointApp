import XCTest
import TestKit
@testable import ListingArts

final class OnArtsListCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtsListCoordinatorTests {
    private func makeSut() -> OnArtsListCoordinator {
        OnArtsListCoordinator(viewController: UIViewController(), interactor: InteractingStub())
    }
}

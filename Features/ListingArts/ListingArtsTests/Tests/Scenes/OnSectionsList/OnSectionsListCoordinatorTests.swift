import XCTest
import TestKit
@testable import ListingArts

final class OnSectionsListCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnSectionsListCoordinatorTests {
    private func makeSut() -> OnSectionsListCoordinator {
        OnSectionsListCoordinator(viewController: UIViewController(), interactor: InteractingStub())
    }
}

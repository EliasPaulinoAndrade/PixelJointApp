import XCTest
import TestKit
@testable import DetailingArt

final class OnArtDetailMinimizedCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailMinimizedCoordinatorTests {
    private func makeSut() -> OnArtDetailMinimizedCoordinator {
        OnArtDetailMinimizedCoordinator(viewController: UIViewController(), interactor: InteractingStub())
    }
}

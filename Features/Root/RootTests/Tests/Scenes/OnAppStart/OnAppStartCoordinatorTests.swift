import XCTest
import TestKit
@testable import Root

final class OnAppStartCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnAppStartCoordinatorTests {
    private func makeSut() -> OnAppStartCoordinator {
        OnAppStartCoordinator(interactor: InteractingStub())
    }
}

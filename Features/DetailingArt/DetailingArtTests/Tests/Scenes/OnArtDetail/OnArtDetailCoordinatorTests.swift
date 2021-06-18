import XCTest
import TestKit
@testable import DetailingArt

final class OnArtDetailCoordinatorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtDetailCoordinatorTests {
    private func makeSut() -> OnArtDetailCoordinator {
        OnArtDetailCoordinator(interactor: InteractingStub())
    }
}

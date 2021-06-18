import XCTest
@testable import ListingArts

//sourcery: spy
extension OnImageFullSizePresenting { }

final class OnImageFullSizeInteractorTests: XCTestCase {
    private let presenterSpy = OnImageFullSizePresentingSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnImageFullSizeInteractorTests {
    private func makeSut() -> OnImageFullSizeInteractor {
        let interactor = OnImageFullSizeInteractor(presenter: presenterSpy)
        return interactor
    }
}

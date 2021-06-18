import XCTest
@testable import Root


final class OnAppStartInteractorTests: XCTestCase {

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnAppStartInteractorTests {
    private func makeSut() -> OnAppStartInteractor {
        let interactor = OnAppStartInteractor()
        return interactor
    }
}

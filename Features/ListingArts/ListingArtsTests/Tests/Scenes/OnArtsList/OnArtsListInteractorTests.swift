import XCTest
@testable import ListingArts

//sourcery: spy
extension OnArtsListPresenting { }

final class OnArtsListInteractorTests: XCTestCase {
    private let presenterSpy = OnArtsListPresentingSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnArtsListInteractorTests {
    private func makeSut() -> OnArtsListInteractor {
        let interactor = OnArtsListInteractor(presenter: presenterSpy)
        return interactor
    }
}

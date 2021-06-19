import XCTest
@testable import ListingArts

//sourcery: spy
extension OnSectionsListPresenting { }

final class OnSectionsListInteractorTests: XCTestCase {
    private let presenterSpy = OnSectionsListPresentingSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnSectionsListInteractorTests {
    private func makeSut() -> OnSectionsListInteractor {
        let interactor = OnSectionsListInteractor(presenter: presenterSpy)
        return interactor
    }
}

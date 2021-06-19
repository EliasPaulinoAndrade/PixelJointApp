import XCTest
@testable import ListingArts

//sourcery: spy
extension OnSectionsListViewable { }

final class OnSectionsListPresenterTests: XCTestCase {
    private let viewSpy = OnSectionsListViewableSpy()

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}

extension OnSectionsListPresenterTests {
    private func makeSut() -> OnSectionsListPresenter {
        OnSectionsListPresenter(view: viewSpy)
    }
}

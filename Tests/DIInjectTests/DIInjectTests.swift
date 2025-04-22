
import XCTest
@testable import DIInject

final class DIInjectTests: XCTestCase {
    func test_salam() {
        let result = DIInject.hello()
        XCTAssertEqual(result, "Hello from DIInject!")
    }
}
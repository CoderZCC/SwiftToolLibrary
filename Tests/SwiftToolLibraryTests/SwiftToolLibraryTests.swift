import XCTest
@testable import SwiftToolLibrary

final class SwiftToolLibraryTests: XCTestCase {
    
    
    func testExample() {

    }
    
    static var allTests = [
        ("testExample", testExample),
        ("testString", testString),
    ]
    
    
    func testString() {
        let str: String = "我1"
        XCTAssertEqual(3, str.ex.byteCount)
    }
    
}

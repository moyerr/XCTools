import XCTest
@testable import XCTools

final class XCToolsTests: XCTestCase {
    func testExample() throws {
      try ExportOptions(compileBitcode: true).write(to: "/tmp/export-options.plist")
    }
}

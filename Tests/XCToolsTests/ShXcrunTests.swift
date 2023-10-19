import XCTest
@testable import XCTools

final class ShXcrunTests: XCTestCase {
    func testExample() throws {
      try ExportOptions(compileBitcode: true).write(to: "/tmp/export-options.plist")
    }
}

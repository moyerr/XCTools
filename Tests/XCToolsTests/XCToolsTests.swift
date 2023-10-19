import XCTest
@testable import XCTools

final class XCToolsTests: XCTestCase {
    func testExample() async throws {
      try await ExportOptions(compileBitcode: true)
            .write(to: "/tmp/export-options.plist")
    }
}

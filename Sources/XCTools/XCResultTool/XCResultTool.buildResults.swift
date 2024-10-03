import Foundation
import Sh

extension XCResultTool {
    /// Get a high level description of build action, the run destination for
    /// which the build was performed, and other metadata along with warnings
    /// and issues.
    public func buildResuts() async throws -> BuildResults {
        let command = serializeCommand("build-results")

        return try await sh(BuildResults.self, decodedBy: Self.decoder, command)
    }
}

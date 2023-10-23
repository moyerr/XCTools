import Foundation
import Sh

extension Altool {
    public func validateApp(
        _ sink: Sink = .terminal,
        file: String,
        platform: Platform
    ) async throws {
        let command = "xcrun altool --validate-app -f \(file) -t \(platform) \(credential.serialized)"

        try await sh(sink, command, environment: credential.environment)
    }
}

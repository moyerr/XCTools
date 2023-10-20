import Foundation
import Sh

extension Altool {
    public func uploadApp(
        _ sink: Sink = .terminal,
        file: String,
        platform: Platform,
        transport: [Transport]? = nil
    ) async throws {
        var buffer = "xcrun altool --upload-app -f \(file) -t \(platform) \(credential.serialized)"

        if let transport {
            buffer.append(transport.serialized)
        }

        try await sh(sink, buffer, environment: credential.environment)
    }
}

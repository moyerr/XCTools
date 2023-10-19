import Sh

extension Simctl {

  /**
   Shutdown a device.
   */
  public func shutdown(_ sink: Sink = .terminal) async throws {
    try await sh(sink, "xcrun simctl shutdown '\(name)'")
  }
}

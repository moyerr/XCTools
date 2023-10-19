import Sh

extension Simctl {

  /**
   Erase a device.
   */
  public func erase(_ sink: Sink = .terminal) async throws {
    try await sh(sink, "xcrun simctl erase '\(name)'")
  }
}

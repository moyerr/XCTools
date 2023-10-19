import Sh

extension Simctl {

  /**
   Shutdown all running devices
   */
  public static func shutdownAll(_ sink: Sink = .terminal) async throws {
    try await sh(sink, "xcrun simctl shutdown all")
  }
}

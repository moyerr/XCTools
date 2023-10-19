import Sh

extension Simctl {

  /**
   Erase all running devices
   */
  public static func eraseAll(_ sink: Sink = .terminal) async throws {
    try await sh(sink, "xcrun simctl erase all")
  }
}

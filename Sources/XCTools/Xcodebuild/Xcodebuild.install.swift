import Sh

extension Xcodebuild {
  /// Build the target and install it into the target's
  /// installation directory in the distribution root (DSTROOT).
  public func install(_ sink: Sink = .terminal) async throws {
    try await sh(sink, serializedCommand(action: "install"))
  }
}

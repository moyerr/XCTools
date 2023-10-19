import Sh

extension Xcodebuild {

  /// Remove build products and intermediate files from
  /// the build root (SYMROOT).
  public func clean(_ sink: Sink = .terminal) async throws {
    try await sh(sink, serializedCommand(action: "clean"))
  }
}

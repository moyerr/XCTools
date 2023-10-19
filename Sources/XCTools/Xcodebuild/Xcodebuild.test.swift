import Sh

extension Xcodebuild {
  public func test(_ sink: Sink = .terminal) async throws {
    try await sh(sink, serializedCommand(action: "test"))
  }
}

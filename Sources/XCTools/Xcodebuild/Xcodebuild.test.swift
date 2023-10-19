import Sh

extension Xcodebuild {
    public func test(
        _ sink: Sink = .terminal,
        testPlan: String? = nil
    ) async throws {
        var action = ""

        if let testPlan {
            action.append("-testPlan \(testPlan) ")
        }

        action.append("test")

        try await sh(sink, serializedCommand(action: action))
    }
}

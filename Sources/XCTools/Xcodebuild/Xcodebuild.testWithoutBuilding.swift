import Sh

extension Xcodebuild {
    /// Test compiled bundles. If a `scheme` is provided then
    /// the command finds bundles in the build root (SRCROOT).
    /// If an xctestrun file is provided then the command finds
    /// bundles at paths specified in the xctestrun file.
    public func testWithoutBuilding(
        _ sink: Sink = .terminal,
        testPlan: String? = nil,
        xctestrun: String? = nil
    ) async throws {
        var action = ""

        if let xctestrun {
            action.append("-xctestrun \(xctestrun) ")
        }

        if let testPlan {
            action.append("-testPlan \(testPlan) ")
        }

        action.append("test-without-building")

        try await sh(sink, serializedCommand(action: action))
    }
}

import Foundation
import Sh

extension XCResultTool {
    /// Get test report summary.
    public func testResultsSummary() async throws -> TestResults.Summary {
        let command = serializeTestResultsCommand(.summary)
        return try await sh(TestResults.Summary.self, decodedBy: Self.decoder, command)
    }

    /// Get all tests from test report.
    public func testResultsTests() async throws -> TestResults.Tests {
        let command = serializeTestResultsCommand(.tests)
        return try await sh(TestResults.Tests.self, decodedBy: Self.decoder, command)
    }

    /// Get detailed information about the test.
    public func testResultsTestDetails(testId: String) async throws -> TestResults.TestDetails {
        let command = serializeTestResultsCommand(.testDetails(testId: testId))
        return try await sh(TestResults.TestDetails.self, decodedBy: Self.decoder, command)
    }

    /// Get the activity trees for the specified test. If the test
    /// has more than one run, the activity trees for each run will
    /// be included.
    public func testResultsActivities(testId: String) async throws -> TestResults.Activities {
        let command = serializeTestResultsCommand(.activities(testId: testId))
        return try await sh(TestResults.Activities.self, decodedBy: Self.decoder, command)
    }

    /// Get test report insights.
    public func testResultsInsights() async throws -> TestResults.Insights {
        let command = serializeTestResultsCommand(.insights)
        return try await sh(TestResults.Insights.self, decodedBy: Self.decoder, command)
    }
}

extension XCResultTool {
    private enum TestResultsSubcommand {
        case summary
        case tests
        case testDetails(testId: String)
        case activities(testId: String)
        case insights

        var serialized: String {
            switch self {
            case .summary:              "summary"
            case .tests:                "tests"
            case .testDetails(let id):  "test-details --test-id '\(id)'"
            case .activities(let id):   "activities --test-id '\(id)'"
            case .insights:             "insights"
            }
        }
    }

    private func serializeTestResultsCommand(_ subcommand: TestResultsSubcommand) -> String {
        serializeCommand("test-results \(subcommand.serialized)")
    }
}

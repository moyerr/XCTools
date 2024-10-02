import Foundation
import Sh

extension XCResultTool {
    private enum TestResultsSubcommand {
        /// Get test report summary.
        case summary
        /// Get all tests from test report.
        case tests
        /// Get detailed information about the test.
        case testDetails(testId: String)
        /// Get test report insights.
        case insights

        var command: String {
            switch self {
            case .summary:              "summary"
            case .tests:                "tests"
            case .testDetails(let id):  "test-details --test-id \(id)"
            case .insights:             "insights"
            }
        }
    }

    public func testResultsSummary() async throws -> TestResults.Summary {
        let subcommand = "test-results \(TestResultsSubcommand.summary.command)"
        let command = serializeCommand(subcommand)

        return try await sh(TestResults.Summary.self, decodedBy: Self.decoder, command)
    }

    public enum TestResults {
        public struct Configuration: Codable, Hashable, Sendable {
            public var configurationId: String
            public var configurationName: String

            public init(
                configurationId: String,
                configurationName: String
            ) {
                self.configurationId = configurationId
                self.configurationName = configurationName
            }

            private enum CodingKeys: String, CodingKey {
                case configurationId
                case configurationName
            }
        }
        
        public struct Summary: Codable, Hashable, Sendable {
            public var title: String
            public var startTime: Date?
            public var finishTime: Date?
            /// Description of the Test Plan, OS, and environment that was used during testing
            public var environmentDescription: String
            public var topInsights: [InsightSummary]
            public var result: TestResult
            public var totalTestCount: Int
            public var passedTests: Int
            public var failedTests: Int
            public var skippedTests: Int
            public var expectedFailures: Int
            public var statistics: [Statistic]
            public var devicesAndConfigurations: [DeviceAndConfigurationSummary]
            public var testFailures: [TestFailure]

            public init(
                title: String,
                startTime: Date? = nil,
                finishTime: Date? = nil,
                environmentDescription: String,
                topInsights: [InsightSummary],
                result: TestResult,
                totalTestCount: Int,
                passedTests: Int,
                failedTests: Int,
                skippedTests: Int,
                expectedFailures: Int,
                statistics: [Statistic],
                devicesAndConfigurations: [DeviceAndConfigurationSummary],
                testFailures: [TestFailure]
            ) {
                self.title = title
                self.startTime = startTime
                self.finishTime = finishTime
                self.environmentDescription = environmentDescription
                self.topInsights = topInsights
                self.result = result
                self.totalTestCount = totalTestCount
                self.passedTests = passedTests
                self.failedTests = failedTests
                self.skippedTests = skippedTests
                self.expectedFailures = expectedFailures
                self.statistics = statistics
                self.devicesAndConfigurations = devicesAndConfigurations
                self.testFailures = testFailures
            }

            private enum CodingKeys: String, CodingKey {
                case title
                case startTime
                case finishTime
                case environmentDescription
                case topInsights
                case result
                case totalTestCount
                case passedTests
                case failedTests
                case skippedTests
                case expectedFailures
                case statistics
                case devicesAndConfigurations
                case testFailures
            }
        }

        public struct TestFailure: Codable, Hashable, Sendable {
            public var testName: String
            public var targetName: String
            public var failureText: String
            public var testIdentifier: Int64

            public init(
                testName: String,
                targetName: String,
                failureText: String,
                testIdentifier: Int64
            ) {
                self.testName = testName
                self.targetName = targetName
                self.failureText = failureText
                self.testIdentifier = testIdentifier
            }

            private enum CodingKeys: String, CodingKey {
                case testName
                case targetName
                case failureText
                case testIdentifier
            }
        }

        public enum TestResult: String, Codable, Hashable, Sendable, CaseIterable {
            case passed = "Passed"
            case failed = "Failed"
            case skipped = "Skipped"
            case expectedFailure = "Expected Failure"
            case unknown = "unknown"
        }

        public struct Statistic: Codable, Hashable, Sendable {
            public var title: String
            public var subtitle: String

            public init(
                title: String,
                subtitle: String
            ) {
                self.title = title
                self.subtitle = subtitle
            }

            private enum CodingKeys: String, CodingKey {
                case title
                case subtitle
            }
        }

        public struct DeviceAndConfigurationSummary: Codable, Hashable, Sendable {
            public var device: Device
            public var testPlanConfiguration: Configuration
            public var passedTests: Int
            public var failedTests: Int
            public var skippedTests: Int
            public var expectedFailures: Int

            public init(
                device: Device,
                testPlanConfiguration: Configuration,
                passedTests: Int,
                failedTests: Int,
                skippedTests: Int,
                expectedFailures: Int
            ) {
                self.device = device
                self.testPlanConfiguration = testPlanConfiguration
                self.passedTests = passedTests
                self.failedTests = failedTests
                self.skippedTests = skippedTests
                self.expectedFailures = expectedFailures
            }

            private enum CodingKeys: String, CodingKey {
                case device
                case testPlanConfiguration
                case passedTests
                case failedTests
                case skippedTests
                case expectedFailures
            }
        }

        public struct InsightSummary: Codable, Hashable, Sendable {
            public var impact: String
            public var category: String
            public var text: String

            public init(
                impact: String,
                category: String,
                text: String
            ) {
                self.impact = impact
                self.category = category
                self.text = text
            }

            private enum CodingKeys: String, CodingKey {
                case impact
                case category
                case text
            }
        }
    }
}

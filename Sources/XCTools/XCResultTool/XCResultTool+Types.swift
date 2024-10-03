import Foundation

extension XCResultTool {

    // MARK: - Common

    public struct Device: Codable, Hashable, Sendable {
        public var deviceId: String?
        public var deviceName: String
        public var architecture: String
        public var modelName: String
        public var platform: String?
        public var osVersion: String

        public init(
            deviceId: String? = nil,
            deviceName: String,
            architecture: String,
            modelName: String,
            platform: String? = nil,
            osVersion: String
        ) {
            self.deviceId = deviceId
            self.deviceName = deviceName
            self.architecture = architecture
            self.modelName = modelName
            self.platform = platform
            self.osVersion = osVersion
        }

        private enum CodingKeys: String, CodingKey {
            case deviceId
            case deviceName
            case architecture
            case modelName
            case platform
            case osVersion
        }
    }

    // MARK: - Build Results

    public struct BuildResults: Codable, Hashable, Sendable {
        public var actionTitle: String?
        public var destination: Device
        public var startTime: Date
        public var endTime: Date
        public var status: String?
        public var analyzerWarningCount: Int?
        public var errorCount: Int?
        public var warningCount: Int?
        public var analyzerWarnings: [Issue]
        public var warnings: [Issue]
        public var errors: [Issue]

        public init(
            actionTitle: String? = nil,
            destination: Device,
            startTime: Date,
            endTime: Date,
            status: String? = nil,
            analyzerWarningCount: Int? = nil,
            errorCount: Int? = nil,
            warningCount: Int? = nil,
            analyzerWarnings: [Issue],
            warnings: [Issue],
            errors: [Issue]
        ) {
            self.actionTitle = actionTitle
            self.destination = destination
            self.startTime = startTime
            self.endTime = endTime
            self.status = status
            self.analyzerWarningCount = analyzerWarningCount
            self.errorCount = errorCount
            self.warningCount = warningCount
            self.analyzerWarnings = analyzerWarnings
            self.warnings = warnings
            self.errors = errors
        }

        private enum CodingKeys: String, CodingKey {
            case actionTitle
            case destination
            case startTime
            case endTime
            case status
            case analyzerWarningCount
            case errorCount
            case warningCount
            case analyzerWarnings
            case warnings
            case errors
        }

        // MARK: Issue

        public struct Issue: Codable, Hashable, Sendable {
            public var issueType: String
            public var message: String
            public var targetName: String?
            public var sourceURL: String?
            public var className: String?

            public init(
                issueType: String,
                message: String,
                targetName: String? = nil,
                sourceURL: String? = nil,
                className: String? = nil
            ) {
                self.issueType = issueType
                self.message = message
                self.targetName = targetName
                self.sourceURL = sourceURL
                self.className = className
            }

            private enum CodingKeys: String, CodingKey {
                case issueType
                case message
                case targetName
                case sourceURL
                case className
            }
        }
    }

    // MARK: - Test Results

    public enum TestResults {

        // MARK: Common

        public struct ArgumentsPayload: Codable, Hashable, Sendable {
            public var value: String

            public init(value: String) {
                self.value = value
            }

            private enum CodingKeys: String, CodingKey {
                case value
            }
        }

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

        public struct TestNode: Codable, Hashable, Sendable {
            public var nodeIdentifier: String?
            public var nodeType: TestNodeType
            public var name: String
            public var details: String?
            public var duration: String?
            public var result: TestResult?
            public var tags: [String]?
            public var children: [TestNode]?

            public init(
                nodeIdentifier: String? = nil,
                nodeType: TestNodeType,
                name: String,
                details: String? = nil,
                duration: String? = nil,
                result: TestResult? = nil,
                tags: [String]? = nil,
                children: [TestNode]? = nil
            ) {
                self.nodeIdentifier = nodeIdentifier
                self.nodeType = nodeType
                self.name = name
                self.details = details
                self.duration = duration
                self.result = result
                self.tags = tags
                self.children = children
            }

            private enum CodingKeys: String, CodingKey {
                case nodeIdentifier
                case nodeType
                case name
                case details
                case duration
                case result
                case tags
                case children
            }

            public enum TestNodeType: String, Codable, Hashable, Sendable, CaseIterable {
                case testPlan = "Test Plan"
                case unitTestbundle = "Unit test bundle"
                case uiTestBundle = "UI test bundle"
                case testSuite = "Test Suite"
                case testCase = "Test Case"
                case device = "Device"
                case testPlanConfiguration = "Test Plan Configuration"
                case arguments = "Arguments"
                case repetition = "Repetition"
                case testCaseRun = "Test Case Run"
                case failureMessage = "Failure Message"
                case sourceCodeReference = "Source Code Reference"
                case attachment = "Attachment"
                case expression = "Expression"
                case testValue = "Test Value"
            }
        }

        public enum TestResult: String, Codable, Hashable, Sendable, CaseIterable {
            case passed = "Passed"
            case failed = "Failed"
            case skipped = "Skipped"
            case expectedFailure = "Expected Failure"
            case unknown = "unknown"
        }

        // MARK: Summary

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

        // MARK: Tests

        public struct Tests: Codable, Hashable, Sendable {
            public var testPlanConfigurations: [Configuration]
            public var devices: [Device]
            public var testNodes: [TestNode]

            public init(
                testPlanConfigurations: [Configuration],
                devices: [Device],
                testNodes: [TestNode]
            ) {
                self.testPlanConfigurations = testPlanConfigurations
                self.devices = devices
                self.testNodes = testNodes
            }

            private enum CodingKeys: String, CodingKey {
                case testPlanConfigurations
                case devices
                case testNodes
            }
        }

        // MARK: Test Details

        public struct TestDetails: Codable, Hashable, Sendable {
            public var testIdentifier: String
            public var testName: String
            public var testDescription: String
            public var duration: String
            public var startTime: Date?
            public var testPlanConfigurations: [Configuration]
            public var devices: [Device]
            public var arguments: [ArgumentsPayload]?
            public var testRuns: [TestNode]
            public var testResult: TestResult
            public var hasPerformanceMetrics: Bool
            public var hasMediaAttachments: Bool
            public var tags: [String]?
            public var bugs: [Bug]?
            public var functionName: String?

            public init(
                testIdentifier: String,
                testName: String,
                testDescription: String,
                duration: String,
                startTime: Date? = nil,
                testPlanConfigurations: [Configuration],
                devices: [Device],
                arguments: [ArgumentsPayload]? = nil,
                testRuns: [TestNode],
                testResult: TestResult,
                hasPerformanceMetrics: Bool,
                hasMediaAttachments: Bool,
                tags: [String]? = nil,
                bugs: [Bug]? = nil,
                functionName: String? = nil
            ) {
                self.testIdentifier = testIdentifier
                self.testName = testName
                self.testDescription = testDescription
                self.duration = duration
                self.startTime = startTime
                self.testPlanConfigurations = testPlanConfigurations
                self.devices = devices
                self.arguments = arguments
                self.testRuns = testRuns
                self.testResult = testResult
                self.hasPerformanceMetrics = hasPerformanceMetrics
                self.hasMediaAttachments = hasMediaAttachments
                self.tags = tags
                self.bugs = bugs
                self.functionName = functionName
            }

            private enum CodingKeys: String, CodingKey {
                case testIdentifier
                case testName
                case testDescription
                case duration
                case startTime
                case testPlanConfigurations
                case devices
                case arguments
                case testRuns
                case testResult
                case hasPerformanceMetrics
                case hasMediaAttachments
                case tags
                case bugs
                case functionName
            }
        }

        public struct Bug: Codable, Hashable, Sendable {
            public var url: URL?
            public var identifier: String?
            public var title: String?

            public init(
                url: URL? = nil,
                identifier: String? = nil,
                title: String? = nil
            ) {
                self.url = url
                self.identifier = identifier
                self.title = title
            }

            private enum CodingKeys: String, CodingKey {
                case url
                case identifier
                case title
            }
        }

        // MARK: Activities

        public struct Activities: Codable, Hashable, Sendable {
            public var testIdentifier: String
            public var testName: String
            public var testRuns: [TestRunActivities]

            public init(
                testIdentifier: String,
                testName: String,
                testRuns: [TestRunActivities]
            ) {
                self.testIdentifier = testIdentifier
                self.testName = testName
                self.testRuns = testRuns
            }

            private enum CodingKeys: String, CodingKey {
                case testIdentifier
                case testName
                case testRuns
            }
        }

        public struct TestRunActivities: Codable, Hashable, Sendable {
            public var device: Device
            public var testPlanConfiguration: Configuration
            public var arguments: [ArgumentsPayload]?
            public var activities: [ActivityNode]

            public init(
                device: Device,
                testPlanConfiguration: Configuration,
                arguments: [ArgumentsPayload]? = nil,
                activities: [ActivityNode]
            ) {
                self.device = device
                self.testPlanConfiguration = testPlanConfiguration
                self.arguments = arguments
                self.activities = activities
            }

            private enum CodingKeys: String, CodingKey {
                case device
                case testPlanConfiguration
                case arguments
                case activities
            }
        }

        public struct ActivityNode: Codable, Hashable, Sendable {
            public var title: String
            public var startTime: Date?
            public var attachments: [Attachment]?
            public var childActivities: [ActivityNode]?

            public init(
                title: String,
                startTime: Date? = nil,
                attachments: [Attachment]? = nil,
                childActivities: [ActivityNode]? = nil
            ) {
                self.title = title
                self.startTime = startTime
                self.attachments = attachments
                self.childActivities = childActivities
            }

            private enum CodingKeys: String, CodingKey {
                case title
                case startTime
                case attachments
                case childActivities
            }
        }

        public struct Attachment: Codable, Hashable, Sendable {
            public var name: String
            public var payloadId: String?
            public var uuid: String
            public var timestamp: Date
            public var lifetime: String?

            public init(
                name: String,
                payloadId: String? = nil,
                uuid: String,
                timestamp: Date,
                lifetime: String? = nil
            ) {
                self.name = name
                self.payloadId = payloadId
                self.uuid = uuid
                self.timestamp = timestamp
                self.lifetime = lifetime
            }

            private enum CodingKeys: String, CodingKey {
                case name
                case payloadId
                case uuid
                case timestamp
                case lifetime
            }
        }

        // MARK: Insights

        public struct Insights: Codable, Hashable, Sendable {
            public var commonFailureInsights: [CommonFailureInsight]
            public var longestTestRunsInsights: [LongestTestRunsInsight]
            public var failureDistributionInsights: [FailureDistributionInsight]

            public init(
                commonFailureInsights: [CommonFailureInsight],
                longestTestRunsInsights: [LongestTestRunsInsight],
                failureDistributionInsights: [FailureDistributionInsight]
            ) {
                self.commonFailureInsights = commonFailureInsights
                self.longestTestRunsInsights = longestTestRunsInsights
                self.failureDistributionInsights = failureDistributionInsights
            }

            private enum CodingKeys: String, CodingKey {
                case commonFailureInsights
                case longestTestRunsInsights
                case failureDistributionInsights
            }

            public struct CommonFailureInsight: Codable, Hashable, Sendable {
                public var failuresCount: Int
                public var impact: String
                public var description: String
                public var associatedTestIdentifiers: [String]

                public init(
                    failuresCount: Int,
                    impact: String,
                    description: String,
                    associatedTestIdentifiers: [String]
                ) {
                    self.failuresCount = failuresCount
                    self.impact = impact
                    self.description = description
                    self.associatedTestIdentifiers = associatedTestIdentifiers
                }

                private enum CodingKeys: String, CodingKey {
                    case failuresCount
                    case impact
                    case description
                    case associatedTestIdentifiers
                }
            }

            public struct LongestTestRunsInsight: Codable, Hashable, Sendable {
                public var title: String
                public var impact: String
                public var associatedTestIdentifiers: [String]
                public var targetName: String
                public var testPlanConfigurationName: String
                public var deviceName: String
                public var osNameAndVersion: String
                public var durationOfSlowTests: Double
                public var meanTime: String

                public init(
                    title: String,
                    impact: String,
                    associatedTestIdentifiers: [String],
                    targetName: String,
                    testPlanConfigurationName: String,
                    deviceName: String,
                    osNameAndVersion: String,
                    durationOfSlowTests: Double,
                    meanTime: String
                ) {
                    self.title = title
                    self.impact = impact
                    self.associatedTestIdentifiers = associatedTestIdentifiers
                    self.targetName = targetName
                    self.testPlanConfigurationName = testPlanConfigurationName
                    self.deviceName = deviceName
                    self.osNameAndVersion = osNameAndVersion
                    self.durationOfSlowTests = durationOfSlowTests
                    self.meanTime = meanTime
                }

                private enum CodingKeys: String, CodingKey {
                    case title
                    case impact
                    case associatedTestIdentifiers
                    case targetName
                    case testPlanConfigurationName
                    case deviceName
                    case osNameAndVersion
                    case durationOfSlowTests
                    case meanTime
                }
            }

            public struct FailureDistributionInsight: Codable, Hashable, Sendable {
                public var title: String
                public var impact: Int
                public var distributionPercent: Double
                public var associatedTestIdentifiers: [String]
                public var bug: String?
                public var tag: String?
                public var destinations: [DestinationsPayload]?

                public struct DestinationsPayload: Codable, Hashable, Sendable {
                    public var deviceName: String
                    public var configurationName: String

                    public init(
                        deviceName: String,
                        configurationName: String
                    ) {
                        self.deviceName = deviceName
                        self.configurationName = configurationName
                    }

                    private enum CodingKeys: String, CodingKey {
                        case deviceName
                        case configurationName
                    }
                }

                public init(
                    title: String,
                    impact: Int,
                    distributionPercent: Double,
                    associatedTestIdentifiers: [String],
                    bug: String? = nil,
                    tag: String? = nil,
                    destinations: [DestinationsPayload]? = nil
                ) {
                    self.title = title
                    self.impact = impact
                    self.distributionPercent = distributionPercent
                    self.associatedTestIdentifiers = associatedTestIdentifiers
                    self.bug = bug
                    self.tag = tag
                    self.destinations = destinations
                }

                private enum CodingKeys: String, CodingKey {
                    case title
                    case impact
                    case distributionPercent
                    case associatedTestIdentifiers
                    case bug
                    case tag
                    case destinations
                }
            }
        }
    }
}

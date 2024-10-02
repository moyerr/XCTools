import Foundation
import Sh

extension XCResultTool {
    public func buildResuts() async throws -> BuildResults {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        let command = serializeCommand("build-results")

        return try await sh(BuildResults.self, decodedBy: decoder, command)
    }

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
    }

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

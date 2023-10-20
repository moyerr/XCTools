import Sh
import Foundation

public struct Xcodebuild {

    let project: String?
    let workspace: String?
    let scheme: String?
    let destination: Destination?
    let configuraton: String?
    let arch: [String]?
    let sdk: String?

    let quiet: Bool
    let verbose: Bool
    let showBuildTimingSummary: Bool
    let enableThreadSanitizer: Bool?
    let enableUndefinedBehaviorSanitizer: Bool?
    let enableCodeCoverage: Bool?
    let testLanguage: String?
    let testRegion: String?
    let derivedDataPath: String?
    let resultBundlePath: String?
    let allowProvisioningUpdates: Bool
    let allowProvisioningDeviceRegistration: Bool
    let authenticationKeyPath: String?
    let authenticationKeyID: String?
    let authenticationKeyIssuerID: String?
    let skipPackagePluginValidation: Bool
    let skipMacroValidation: Bool

    public init(
        project: String? = nil,
        workspace: String? = nil,
        scheme: String? = nil,
        destination: Destination? = nil,
        configuraton: String? = nil,
        arch: [String]? = nil,
        sdk: String? = nil,
        quiet: Bool = false,
        verbose: Bool = false,
        showBuildTimingSummary: Bool = false,
        enableThreadSanitizer: Bool? = nil,
        enableUndefinedBehaviorSanitizer: Bool? = nil,
        enableCodeCoverage: Bool? = nil,
        testLanguage: String? = nil,
        testRegion: String? = nil,
        derivedDataPath: String? = nil,
        resultBundlePath: String? = nil,
        allowProvisioningUpdates: Bool = false,
        allowProvisioningDeviceRegistration: Bool = false,
        authenticationKeyPath: String? = nil,
        authenticationKeyID: String? = nil,
        authenticationKeyIssuerID: String? = nil,
        skipPackagePluginValidation: Bool = false,
        skipMacroValidation: Bool = false
    ) {
        self.project = project
        self.workspace = workspace
        self.scheme = scheme
        self.destination = destination
        self.configuraton = configuraton
        self.arch = arch
        self.sdk = sdk
        self.quiet = quiet
        self.verbose = verbose
        self.showBuildTimingSummary = showBuildTimingSummary
        self.enableThreadSanitizer = enableThreadSanitizer
        self.enableUndefinedBehaviorSanitizer = enableUndefinedBehaviorSanitizer
        self.enableCodeCoverage = enableCodeCoverage
        self.testLanguage = testLanguage
        self.testRegion = testRegion
        self.derivedDataPath = derivedDataPath
        self.resultBundlePath = resultBundlePath
        self.allowProvisioningUpdates = allowProvisioningUpdates
        self.allowProvisioningDeviceRegistration = allowProvisioningDeviceRegistration
        self.authenticationKeyPath = authenticationKeyPath
        self.authenticationKeyID = authenticationKeyID
        self.authenticationKeyIssuerID = authenticationKeyIssuerID
        self.skipPackagePluginValidation = skipPackagePluginValidation
        self.skipMacroValidation = skipMacroValidation
    }

    func serializedCommand(action: String) -> String {
        var buffer = "xcrun xcodebuild"

        if let project = project {
            buffer.append(" -project \(project)")
        }

        if let workspace = workspace {
            buffer.append(" -workspace \(workspace)")
        }

        if let scheme = scheme {
            buffer.append(" -scheme \(scheme)")
        }

        if let destination = destination {
            buffer.append(" -destination \(destination)")
        }

        if let arch = arch {
            for arch in arch {
                buffer.append(" -arch \(arch)")
            }
        }

        if let sdk = sdk {
            buffer.append(" -sdk \(sdk)")
        }

        if quiet {
            buffer.append(" -quiet")
        }

        if verbose {
            buffer.append(" -verbose")
        }

        if showBuildTimingSummary {
            buffer.append(" -showBuildTimingSummary")
        }

        if let enableThreadSanitizer = enableThreadSanitizer {
            let value = enableThreadSanitizer ? "YES" : "NO"
            buffer.append(" -enableThreadSanitizer \(value)")
        }

        if let enableUndefinedBehaviorSanitizer = enableUndefinedBehaviorSanitizer {
            let value = enableUndefinedBehaviorSanitizer ? "YES" : "NO"
            buffer.append(" -enableUndefinedBehaviorSanitizer \(value)")
        }

        if let enableCodeCoverage = enableCodeCoverage {
            let value = enableCodeCoverage ? "YES" : "NO"
            buffer.append(" -enableCodeCoverage \(value)")
        }

        if let testLanguage = testLanguage {
            buffer.append(" -testLanguage \(testLanguage)")
        }

        if let testRegion = testRegion {
            buffer.append(" -testRegion \(testRegion)")
        }

        if let derivedDataPath = derivedDataPath {
            buffer.append(" -derivedDataPath \(derivedDataPath)")
        }

        if let resultBundlePath = resultBundlePath {
            buffer.append(" -resultBundlePath \(resultBundlePath)")
        }

        if allowProvisioningUpdates {
            buffer.append(" -allowProvisioningUpdates")
        }

        if allowProvisioningDeviceRegistration {
            buffer.append(" -allowProvisioningDeviceRegistration")
        }

        if let authenticationKeyPath = authenticationKeyPath {
            buffer.append(" -authenticationKeyPath \(authenticationKeyPath)")
        }

        if let authenticationKeyID = authenticationKeyID {
            buffer.append(" -authenticationKeyID \(authenticationKeyID)")
        }

        if let authenticationKeyIssuerID = authenticationKeyIssuerID {
            buffer.append(" -authenticationKeyIssuerID \(authenticationKeyIssuerID)")
        }

        if skipPackagePluginValidation {
            buffer.append(" -skipPackagePluginValidation")
        }

        if skipMacroValidation {
            buffer.append(" -skipMacroValidation")
        }

        buffer.append(" \(action)")

        return buffer
    }
}

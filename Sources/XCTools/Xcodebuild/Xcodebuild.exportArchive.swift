import Sh

extension Xcodebuild {

    public func exportArchive(
        _ sink: Sink = .terminal,
        archivePath: String,
        exportPath: String? = nil,
        exportOptionsPlistPath: String
    ) async throws {
        var buffer = "xcodebuild -exportArchive -archivePath \(archivePath) -exportOptionsPlist \(exportOptionsPlistPath)"

        if let exportPath = exportPath {
            buffer.append(" -exportPath \(exportPath)")
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

        try await sh(sink, buffer)
    }
}

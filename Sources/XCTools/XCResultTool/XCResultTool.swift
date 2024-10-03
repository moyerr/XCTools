import Foundation

/// A tool for interacting with Xcode result bundles.
///
/// Create an instance of this tool with the path to an Xcode
/// result bundle (`.xcresult`), then use the methods to extract
/// information from the bundle.
public struct XCResultTool {

    /// The result bundle path.
    public let path: String

    /// Create a new instance of the tool.
    ///
    /// - Parameter path: The path to the result bundle.
    public init(path: String) {
        self.path = path
    }
}

extension XCResultTool {
    internal static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    internal func serializeCommand(_ subcommand: String) -> String {
        "xcrun xcresulttool get \(subcommand) --path \(path) --compact"
    }
}

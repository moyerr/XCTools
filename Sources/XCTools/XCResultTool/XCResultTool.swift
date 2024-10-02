import Foundation

public struct XCResultTool {

    internal static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()

    /// The result bundle path.
    public let path: String

    public init(path: String) {
        self.path = path
    }

    func serializeCommand(_ subcommand: String) -> String {
        "xcrun xcresulttool get \(subcommand) --path \(path) --compact"
    }
}

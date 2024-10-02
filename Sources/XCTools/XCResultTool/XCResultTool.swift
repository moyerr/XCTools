import Foundation

public struct XCResultTool {
    /// The result bundle path.
    public let path: String

    public init(path: String) {
        self.path = path
    }

    func serializeCommand(_ subcommand: String) -> String {
        "xcrun xcresulttool get \(subcommand) --path \(path) --compact"
    }
}

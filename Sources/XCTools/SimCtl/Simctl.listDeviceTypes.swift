import Sh

extension Simctl {

  public static func listDeviceTypes() async throws -> [DeviceType] {
    let cmd = "xcrun simctl list -j devicetypes"
    let deviceTypes = try await sh(DeviceTypes.self, cmd)
    return deviceTypes.devicetypes
  }

  public struct DeviceType: Decodable {
    public let productFamily: String
    public let name: String
    public let identifier: Identifier
    public let modelIdentifier: String

    public let bundlePath: String

    public let maxRuntimeVersion: Int
    public let maxRuntimeVersionString: String

    public let minRuntimeVersionString: String
    public let minRuntimeVersion: Int

    public struct Identifier: RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral {
      public typealias StringLiteralType = String
      public let rawValue: String
      public init?(rawValue: String) {
        self.rawValue = rawValue
      }
      public init(stringLiteral: String) {
        self.rawValue = stringLiteral
      }

      public func encode(to encoder: Encoder) async throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
      }

      public init(from decoder: Decoder) async throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
      }
    }
  }

  struct DeviceTypes: Decodable {
    let devicetypes: [DeviceType]
  }
}

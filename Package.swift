// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "XCTools",
  platforms: [
    .macOS(.v12)
  ],
  products: [
    .library(
      name: "XCTools",
      targets: ["XCTools"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/moyerr/sh.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "XCTools",
      dependencies: [
        .product(name: "Sh", package: "sh")
      ]
    ),
    .testTarget(
      name: "XCToolsTests",
      dependencies: ["XCTools"]
    )
  ]
)

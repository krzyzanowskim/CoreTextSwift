// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreTextSwift",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "CoreTextSwift",
            targets: ["CoreTextSwift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreTextSwift",
            dependencies: [])
    ]
)

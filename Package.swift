// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "CoreTextSwift",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(name: "CoreTextSwift", targets: ["CoreTextSwift"])
    ],
    targets: [
        .target(name: "CoreTextSwift")
    ]
)

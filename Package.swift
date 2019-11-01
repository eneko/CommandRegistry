// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "CommandRegistry",
    products: [
        .library(name: "CommandRegistry", targets: ["CommandRegistry"]),
    ],
    dependencies: [
        .package(url: "https://github.com/eneko/Logger.git", from: "0.0.1"),
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "CommandRegistry", dependencies: ["SwiftPM", "Logger"]),
        .testTarget(name: "InternalTests", dependencies: ["CommandRegistry"]),
        .testTarget(name: "PublicTests", dependencies: ["CommandRegistry"])
    ]
)

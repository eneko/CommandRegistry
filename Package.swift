// swift-tools-version:4.0
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
        .target(name: "CommandRegistry", dependencies: ["Utility", "Logger"]),
        .testTarget(name: "CommandRegistryTests", dependencies: ["CommandRegistry"]),
        .testTarget(name: "SampleCLITests", dependencies: ["CommandRegistry", "Utility"])
    ]
)


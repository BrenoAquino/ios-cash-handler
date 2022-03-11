// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Features",
            targets: ["DesignSystem", "Splash", "Overview", "Home", "OperationForm"]),
    ],
    dependencies: [
        .package(name: "Common", path: "../Common"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: ["Common"]),
        .target(
            name: "Splash",
            dependencies: ["Common", "Domain", "DesignSystem"]),
        .target(
            name: "Overview",
            dependencies: ["Common", "Domain", "DesignSystem"]),
        .target(
            name: "Home",
            dependencies: ["Common", "Domain", "DesignSystem"]),
        .target(
            name: "OperationForm",
            dependencies: ["Common", "Domain", "DesignSystem"]),
    ]
)

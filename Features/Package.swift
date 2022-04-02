// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Features",
            targets: ["DesignSystem", "MainTab", "Overview", "Statement", "OperationForm"]),
    ],
    dependencies: [
        .package(name: "Common", path: "../Common"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Previews",
            dependencies: ["Common", "Domain"]),
        .target(
            name: "DesignSystem",
            dependencies: ["Common"]),
        .target(
            name: "MainTab",
            dependencies: ["Previews", "Common", "Domain", "DesignSystem"]),
        .target(
            name: "Overview",
            dependencies: ["Previews", "Common", "Domain", "DesignSystem"]),
        .target(
            name: "Statement",
            dependencies: ["Previews", "Common", "Domain", "DesignSystem"]),
        .target(
            name: "OperationForm",
            dependencies: ["Previews", "Common", "Domain", "DesignSystem"]),
    ]
)

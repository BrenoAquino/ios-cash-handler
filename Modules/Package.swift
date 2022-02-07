// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Modules",
            targets: ["Home", "OperationForm", "Domain", "Data"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Common",
            dependencies: []),
        .target(
            name: "DesignSystem",
            dependencies: []),
        .target(
            name: "Data",
            dependencies: ["Domain", "Common"]),
        .target(
            name: "Domain",
            dependencies: []),
        .target(
            name: "Home",
            dependencies: ["Common", "DesignSystem", "Domain"]),
        .target(
            name: "OperationForm",
            dependencies: ["Common", "DesignSystem", "Domain"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            resources: [.process("Resources/")])
    ]
)

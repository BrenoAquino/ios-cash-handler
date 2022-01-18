// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Modules",
            targets: ["Home", "OperationForm"]),
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
            name: "Home",
            dependencies: ["Common", "DesignSystem"]),
        .target(
            name: "OperationForm",
            dependencies: ["Common", "DesignSystem"]),
    ]
)

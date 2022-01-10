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
            name: "Core",
            dependencies: []),
        .target(
            name: "Home",
            dependencies: ["Core"]),
        .target(
            name: "OperationForm",
            dependencies: ["Core"]),
    ]
)

// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(name: "Common", path: "../Common"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Domain", "Common"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"],
            resources: [.process("Resources/")]),
    ]
)

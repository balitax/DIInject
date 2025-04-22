// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "DIInject",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "DIInject",
            targets: ["DIInject"]),
    ],
    targets: [
        .target(
            name: "DIInject", 
            dependencies: []),

        .testTarget(
            name: "DIInjectTests",
            dependencies: ["DIInject"]),
    ]
)

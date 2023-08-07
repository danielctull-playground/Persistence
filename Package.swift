// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Persistence",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "Persistence", targets: ["Persistence"]),
    ],
    targets: [
        .target(name: "Persistence"),
        .testTarget(name: "PersistenceTests", dependencies: ["Persistence"]),
    ]
)

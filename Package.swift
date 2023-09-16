// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Regolith",
    platforms: [.macOS(.v11),
                .iOS(.v13)],
    products: [
        .library(
            name: "Regolith",
            targets: ["Regolith"]),
    ],
    dependencies: [
        .package(url: "git@github.com:nicklockwood/Euclid.git", branch: "main"),
        .package(url: "git@github.com:3Squared/PeakOperation.git", branch: "develop"),
        .package(path: "../Bivouac"),
    ],
    targets: [
        .target(
            name: "Regolith",
            dependencies: ["Bivouac",
                           "Euclid",
                           "PeakOperation"])
    ]
)

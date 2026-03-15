// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Regolith",
    platforms: [.macOS(.v15),
                .iOS(.v17)],
    products: [
        .library(name: "Regolith",
                 targets: ["Regolith"]),
    ],
    dependencies: [
        .package(path: "../Bivouac"),
        .package(path: "../Deltille"),
        .package(url: "git@github.com:nicklockwood/Euclid.git",
                 branch: "main"),
    ],
    targets: [
        .target(name: "Regolith",
                dependencies: ["Bivouac",
                               "Deltille",
                               "Euclid"])
    ]
)

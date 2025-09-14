// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Regolith",
    platforms: [.macOS(.v14),
                .iOS(.v17)],
    products: [
        .library(name: "Regolith",
                 targets: ["Regolith"]),
    ],
    dependencies: [
//        .package(url: "git@github.com:zilmarinen/Deltille.git",
//                 branch: "main"),
        .package(path: "../Deltille"),
        .package(url: "git@github.com:nicklockwood/Euclid.git",
                 branch: "main"),
        .package(path: "../Lattice"),
    ],
    targets: [
        .target(name: "Regolith",
                dependencies: ["Deltille",
                               "Euclid",
                               "Lattice"])
    ]
)

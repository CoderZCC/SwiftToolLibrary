// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftToolLibrary",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "SwiftToolLibrary",
            targets: ["SwiftToolLibrary", "Extensions"]),
    ],
    targets: [
        .target(
            name: "SwiftToolLibrary",
            dependencies: []),
        .testTarget(
            name: "SwiftToolLibraryTests",
            dependencies: ["SwiftToolLibrary"]),
    ]
)

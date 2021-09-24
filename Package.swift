// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SwiftToolLibrary",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "SwiftToolLibrary", targets: ["SwiftToolLibrary"])
    ],
    targets: [
        .target(
            name: "SwiftToolLibrary",
            path: "Sources"
        )
    ]
)

// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "CBSwiftUIKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .tvOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "CBSwiftUIKit", targets: ["CBSwiftUIKit"]),
    ],
    targets: [
        .target(
            name: "CBSwiftUIKit"
        ),
        .testTarget(
            name: "CBSwiftUIKitTests",
            dependencies: ["CBSwiftUIKit"]),
    ]
)

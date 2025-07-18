// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PaginationKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PaginationKit",
            targets: ["PaginationKit"]
        )
    ],
    targets: [
        .target(
            name: "PaginationKit"
        )
    ]
)

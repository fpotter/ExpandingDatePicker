// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ExpandingDatePicker",
    platforms: [
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "ExpandingDatePicker", targets: ["ExpandingDatePicker"])
    ],
    targets: [
        .target(name: "ExpandingDatePicker", path: "ExpandingDatePicker")
    ])

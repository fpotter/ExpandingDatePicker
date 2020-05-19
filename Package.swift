import PackageDescription

let package = Package(
  name: "ExpandingDatePicker",
  products: [
    .library(name: "ExpandingDatePicker", targets: ["ExpandingDatePicker"])
  ],
  targets: [
    .target(name: "ExpandingDatePicker", path: "ExpandingDatePicker")
  ]
)

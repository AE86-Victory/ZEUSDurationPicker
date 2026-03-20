// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "ZEUSDurationPicker",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "ZEUSDurationPicker",
      targets: ["ZEUSDurationPicker"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ZEUSDurationPicker",
      dependencies: [],
      resources: [.process("Resources")]),
  ])

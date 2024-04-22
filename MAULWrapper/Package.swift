// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MAULWrapper",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "MAULWrapper",
      targets: ["MAULWrapper"]),
  ],
  dependencies: [
    .package(id: "moap.maul", from: "5.8.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "MAULWrapper",
      dependencies: [
        .product(name: "MAUL", package: "moap.maul")
      ]
    ),
    .testTarget(
      name: "MAULWrapperTests",
      dependencies: ["MAULWrapper"]),
  ]
)

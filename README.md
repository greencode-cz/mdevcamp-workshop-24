For the time being, MAUL library is available from Skoda Auto's jfrog repository. Github is planned for the near future.

1. Add a Package to your existing project <kbd>⌃</kbd><kbd>⌘</kbd><kbd>⇧</kbd><kbd>N</kbd>. You can name it `MAULWrapper` for example and add it to the current project.

2. In the terminal write: `swift package-registry set --global "https://artifactory.skoda.vwgroup.com/artifactory/api/swift/swift-maul-swift-public"`

3. Modify the existing `Package.swift` from the `MAULWrapper` package:

```swift
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
```

4. Just in case check the project `Package Dependencies` for `MAULWrapper`. If not present add it.

<img width="1236" alt="Screenshot 2024-04-22 at 17 29 22" src="https://gist.github.com/assets/127192432/fbc066fd-2bc5-432e-b7e9-a967519507a4">



// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CozyData",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "cozy-data-builder", targets: ["CozyDataBuilder"])
    ],
    targets: [
        .executableTarget(name: "CozyDataBuilder")
    ]
)

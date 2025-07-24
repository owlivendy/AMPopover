// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AMPopover",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AMPopover",
            targets: ["AMPopover"]),
            
    ],
    targets: [
        .target(
            name: "AMPopover",
            dependencies: [],
            resources: [
                .process("Resources")
            ])
    ]
) 

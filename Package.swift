// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-protobuf-poc",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.15.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.1")
    ],
    
    targets: [
        .helloWorldServer,
        .helloWorldClient,
        .helloWorldModel,
        .HelloWorld
    ]
    
)

extension Target.Dependency {
    
    static let grpc: Self = .product(name: "GRPC", package: "grpc-swift")
    static let argumentParser: Self = .product(
        name: "ArgumentParser",
        package: "swift-argument-parser"
    )
    static let protobuf: Self = .product(name: "SwiftProtobuf", package: "swift-protobuf")
    static let helloWorldModel: Self = .target(name: "HelloWorldModel")
    static let HelloWorld: Self = .target(name: "HelloWorld")
    
}

extension Target {
    
    static let HelloWorld: Target = .executableTarget(
        name: "HelloWorld",
        dependencies: [
            .grpc,
            .protobuf,
            .argumentParser,
            .helloWorldModel
        ],
        path: "Sources/main")
    
    
    static let helloWorldServer: Target = .executableTarget(
        name: "HelloWorldServer",
        dependencies: [
            .grpc,
            .protobuf,
            .argumentParser,
            .helloWorldModel
        ],
        path: "Sources/Server/"
    )
    
    static let helloWorldClient: Target = .executableTarget(
        name: "HelloWorldClient",
        dependencies: [
            .grpc,
            .protobuf,
            .argumentParser,
            .helloWorldModel,
            .HelloWorld,
        ],
        path: "Sources/Client/"
    )
    
    static let helloWorldModel: Target = .target(
        name: "HelloWorldModel",
        dependencies: [
            .grpc,
            .protobuf,
        ],
        path: "Sources/Model",
        exclude: [
            "helloworld.proto",
        ]
    )
}

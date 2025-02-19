// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

enum Target: CaseIterable {
    case countryDetail
    case worldViewApiClient
    case worldViewCoreKit

    var name: String {
        switch self {
        case .countryDetail: "CountryDetail"
        case .worldViewApiClient: "WorldViewApiClient"
        case .worldViewCoreKit: "WorldViewCoreKit"
        }
    }

    var library: PackageDescription.Product { .libray(target: self) }
    var target: PackageDescription.Target { .target(for: self) }

    var dependencies: [PackageDescription.Target.Dependency] {
        switch self {
        case .countryDetail: [.dependency(for: .worldViewCoreKit)]
        case .worldViewApiClient: [.dependency(for: .worldViewCoreKit)]
        case .worldViewCoreKit: []
        }
    }
}

let package = Package(
    name: "WorldViewCoreKit",
    platforms: [.iOS(.v17)],
    products: Target.allCases.map(\.library),
    targets:
        Target.allCases.map(\.target) +
        [
        .testTarget(
            name: "WorldViewCoreKitTests",
            dependencies: ["WorldViewCoreKit"]),
    ]
)

extension PackageDescription.Product {

    static func libray(target: Target) -> PackageDescription.Product {
        .library(name: target.name, targets: [target.name])
    }
}

extension PackageDescription.Target {

    static func target(for target: Target) -> PackageDescription.Target {
        .target(name: target.name, dependencies: target.dependencies)
    }
}

extension PackageDescription.Target.Dependency {

    static func dependency(for target: Target) -> PackageDescription.Target.Dependency {
        .byName(name: target.name)
    }
}

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "NHAwsHelpers",
	platforms: [
		.macOS(.v13),
		.iOS(.v16),
		.tvOS(.v16),
		.watchOS(.v8),
	],
	products: [
		.library(
			name: "NHAwsHelpers",
			targets: ["NHAwsHelpers"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "3.0.0")),
		.package(url: "https://github.com/mredig/SwiftPizzaSnips.git", .upToNextMajor(from: "0.4.35")),
		.package(url: "https://github.com/NetworkHandler/NHMacros.git", .upToNextMajor(from: "0.0.1")),
		.package(url: "https://github.com/apple/swift-http-types.git", from: "1.5.1"),

	],
	targets: [
		.target(
			name: "NHAwsHelpers",
			dependencies: [
				.product(name: "Crypto", package: "swift-crypto"),
				"SwiftPizzaSnips",
				.product(name: "HTTPTypes", package: "swift-http-types"),
				"NHMacros",
			]
		),
		.testTarget(
			name: "NHAwsHelpersTests",
			dependencies: ["NHAwsHelpers"]
		),
	]
)

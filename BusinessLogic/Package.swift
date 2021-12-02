// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "BusinessLogic",
	products: [
		.library(name: "BusinessLogic", targets: ["BusinessLogic"])
	],
	dependencies: [
		.package(url: "https://github.com/Quick/Nimble.git", from: "9.0.0")
	],
	targets: [
		.target(name: "BusinessLogic", dependencies: []),
		.testTarget(name: "BusinessLogicTests", dependencies: ["BusinessLogic", "Nimble"])
	]
)

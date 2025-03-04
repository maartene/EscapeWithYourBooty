// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "EscapeWithYourBooty",
    products: [
        .executable(name: "EscapeWithYourBooty", targets: ["EscapeWithYourBooty"]),
    ],
    dependencies: [
        // Voeg hier afhankelijkheden toe indien nodig
    ],
    targets: [
        .executableTarget(
            name: "EscapeWithYourBooty",
            dependencies: []
            ),
        .testTarget(
            name: "EscapeWithYourBootyTests",
            dependencies: ["EscapeWithYourBooty"]
            ),
    ]
)

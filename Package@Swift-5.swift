// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "CApache",

  products: [
      .library(name: "CApache", targets: ["CApache"]),
  ],
  targets: [
      .systemLibrary(name: "CApache",
          pkgConfig: "mod_swift",
          providers: [
              .brew(["modswift/mod_swift"]),
              .apt(["apache2-dev"]) // Note: still requires mod_swift install!
          ]
      )
  ]
)

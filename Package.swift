import PackageDescription

let package = Package(
  name: "CApache",

  pkgConfig: "mod_swift",
	
  providers: [
    .Brew("helje5/mod_swift"),
    .Apt("apache2-dev") // Note: still requires mod_swift install!
  ],	
	
  exclude: [
    "README.md",
    "LICENSE",
    "ModuleMaps"
  ]
)

<h2>CApache
  <img src="http://zeezide.com/img/mod_swift.svg"
       align="right" width="128" height="128" />
</h2>

![Apache 2](https://img.shields.io/badge/apache-2-yellow.svg)
![Swift3](https://img.shields.io/badge/swift-3-blue.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![tuxOS](https://img.shields.io/badge/os-tuxOS-green.svg?style=flat)

A Swift system library package (C wrapper) for Apache,
ApachePortableRuntime and APRUtil.
This package is part of the [mod_swift](http://mod-swift.org/) effort.

### Using the Apache Portable Runtime

**Important**: This version of the package **requires** that you install
               `mod_swift`. It installs the necessary shims.

Setup your Package.swift to include CApache:

```Swift
import PackageDescription

let package = Package(
  name: "MyTool",
	
  dependencies: [
    .Package(url: "git@github.com:modswift/CApache.git", majorVersion: 0),
  ]
)
```

Import the CAPR module.

    import CAPR
    import CAPRUtil

### APR Database Example

Access a SQLite3 database using the APR-Util DBD module (zer0 error handling):

```Swift
let connectString = "OpenGroupware.sqlite3"
let sql = "SELECT company_id, login FROM person"

var pool         : OpaquePointer? = nil
var driverHandle : OpaquePointer? = nil
var con          : OpaquePointer? = nil
var res          : OpaquePointer? = nil

apr_pool_initialize()
apr_pool_create_ex(&pool, nil, nil, nil)
apr_dbd_init(pool)
apr_dbd_get_driver(pool, "sqlite3", &driverHandle)
apr_dbd_open(driverHandle, pool, connectString, &con)

apr_dbd_select(driverHandle, pool, con, &res, sql, 0)

var row : OpaquePointer? = nil
while true {
  let rc = apr_dbd_get_row(driverHandle, pool, res, &row, Int32(-1))
  guard rc == 0 else { break }
  
  print("record:")
  let colCount = apr_dbd_num_cols(driverHandle, res)
  for colIdx in 0..<colCount {
    let name : String
    if let cstr = apr_dbd_get_name(driverHandle, res, colIdx) {
      name = String(cString: cstr)
    }
    else {
      name = "[\(colIdx)]"
    }
		
    if let cstr = apr_dbd_get_entry(driverHandle, row, colIdx) {
      print("  \(name) = \(String(cString: cstr))")
    }
    else {
      print("  \(name) IS NULL")
    }
  }
}
```

### Who

**mod_swift** is brought to you by
[ZeeZide](http://zeezide.de).
We like feedback, GitHub stars, cool contract work,
presumably any form of praise you can think of.

There is a `#mod_swift` channel on the [Noze.io Slack](http://slack.noze.io).

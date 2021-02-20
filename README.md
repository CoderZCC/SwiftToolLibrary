# SwiftToolLibrary

SwiftToolLibrary是一款加速swift开发的工具包；

[![Build Status](https://travis-ci.org/SnapKit/SnapKit.svg)](https://travis-ci.org/SnapKit/SnapKit)
[![Platform](https://img.shields.io/cocoapods/p/SnapKit.svg?style=flat)](https://github.com/SnapKit/SnapKit)

## Requirements

- iOS 10.0+
- Xcode 10.0+
- Swift 5.0+

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build SnapKit using Swift Package Manager.

To integrate SnapKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/CoderZCC/SwiftToolLibrary.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

### Quick Start

```swift
import SwiftToolLibrary

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let arr = ["1", "2", "3"]
        print(arr[safe: 1000] ?? "")
    }
}
```

## License

SwiftToolLibrary is released under the MIT license. See LICENSE for details.


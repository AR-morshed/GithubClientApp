# Github Client

[![IDE](https://img.shields.io/badge/Xcode-16.0-blue.svg)](https://developer.apple.com/xcode/)
[![Language](https://img.shields.io/badge/swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/iOS-16-green.svg)](https://developer.apple.com/ios/)

<p align="center">
  GitHub iOS client in SwiftUI, Composable, and Modular Architecture.
</p>

## Content
- [App Features](#app-features)
- [Technologies](#technologies)
- [Building and Running](#building-and-running)
- [Build Configurations](#build-configurations)

## App Features
- [x] Browse developers
- [x] See developer detail
- [x] Open repo in Browser

## Technologies
- [x] The Composable Architecture ([TCA](https://github.com/pointfreeco/swift-composable-architecture))
- [x] SwiftUI, [SwiftUI](https://developer.apple.com/xcode/swiftui/), Structure Concurrency [concurrency](https://developer.apple.com/documentation/swift/concurrency/) and [Combine](https://developer.apple.com/documentation/combine)
- [x] Dependency injection ([swift-dependencies](https://github.com/pointfreeco/swift-dependencies))

## Building and Running
Navigate to the `BuildConfiguration.plist` file in the project navigator and enter the GitHub token for the `githubToken` key. Each build scheme has its own `BuildConfiguration.plist` file, so ensure that the token is added to the corresponding file for each scheme. Each Scheme has a separate bundle identifier.


## Build Configurations
Github Client uses `.xcconfig` and `BuildConfiguration.plist` for managing environment-specific settings.

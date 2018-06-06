# MGBottomSheet

[![CocoaPods compatible](https://img.shields.io/cocoapods/v/MGBottomSheet.svg?style=flat)](https://cocoapods.org/pods/MGBottomSheet) 
[![License: MIT](https://img.shields.io/cocoapods/l/MGBottomSheet.svg?style=flat)](http://opensource.org/licenses/MIT)
[![Swift Version](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://developer.apple.com/swift/) 
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://developer.apple.com/ios/)

`MGBottomSheet` is an iOS drop-in class that displays a bottom sheet with some actions of your election, to do some actions over your project. The Bottom Sheet is meant as a replacement for private `UIKit` `UIAlertController` with some additional features.

## Requirements

`MGBottomSheet` works on iOS 9+ and requires ARC to build. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation.framework
* UIKit.framework

You will need the latest developer tools in order to build `MGBottomSheet`. Old Xcode versions might work, but compatibility will not be explicitly maintained.

## Adding MGBottomSheet to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add MGBottomSheet to your project.

1. Add a pod entry for MGBottomSheet to your Podfile `pod 'MGBottomSheet'`
2. Install the pod(s) by running `pod install`.
3. Include MGBottomSheet wherever you need it with `@import MGBottomSheet` if your project is in Objective-C or `import MGBottomSheet` if your project is in Swift.

# AlertTones

[![CI Status](https://img.shields.io/travis/Duncan Cunningham/AlertTones.svg?style=flat)](https://travis-ci.org/Duncan Cunningham/AlertTones)
[![Version](https://img.shields.io/cocoapods/v/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)
[![License](https://img.shields.io/cocoapods/l/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)
[![Platform](https://img.shields.io/cocoapods/p/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)

Swift library that provides support for using the iOS System Alert Tones from the Settings app. These are the default tones you can select when recieveing a message, found in: *Settings->Notifications->Messages->Sounds*.

The library providers a picker UI similar to what is in the Settings app. Alternatively, if you want to use your own UI, you can use just the core functionality to access the alert tones files.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AlertTones is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile. This will include the picker UI by default.

```ruby
pod 'AlertTones'
```

If you want only want the core functionality, use the `AlertTones/Cores` subspec instead.

## Author

Duncan Cunningham

## License

AlertTones is available under the MIT license. See the LICENSE file for more info.

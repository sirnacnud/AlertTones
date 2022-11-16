# AlertTones

[![Version](https://img.shields.io/cocoapods/v/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)
[![License](https://img.shields.io/cocoapods/l/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)
[![Platform](https://img.shields.io/cocoapods/p/AlertTones.svg?style=flat)](https://cocoapods.org/pods/AlertTones)

Swift library that provides support for using the iOS System Alert Tones from the Settings app. These are the default tones you can select when recieveing a message, found in: *Settings->Notifications->Messages->Sounds*.

The library providers a picker UI similar to what is in the Settings app. Alternatively, if you want to use your own UI, you can use just the core functionality to access the alert tones files.

![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-11-16 at 20 21 13](https://user-images.githubusercontent.com/579727/202274646-f599a10f-1425-46de-a138-7d61e76570eb.png)
![Simulator Screen Shot - iPhone SE (2nd generation) - 2022-11-16 at 20 21 20](https://user-images.githubusercontent.com/579727/202274716-eb36543f-7fb5-46d3-b0cd-f94bc738eed5.png)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- Requires iOS 11
- Tested on iOS 14 & 15

## Installation

AlertTones is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile. This will include the picker UI by default.

```ruby
pod 'AlertTones'
```

If you want only want the core functionality, use the `AlertTones/Cores` subspec instead.

## Simulator Support
The sound files for the simulator are included inside the Xcode.app package. By default the library will try to use `/Applications/Xcode.app`.

If you have Xcode named something different or installed to a different location, you can use the `Info.plist` to specify the path with a key named `"XcodePath"`. Take a look at the [usage](https://github.com/sirnacnud/AlertTones/blob/6f7e10b499ddf8a21655f16db407480b784ac272/Example/AlertTones/Info.plist#L5) in the example app.

## Author

Duncan Cunningham

## License

AlertTones is available under the MIT license. See the LICENSE file for more info.

# ExpandingDatePicker

<img src="https://github.com/fpotter/ExpandingDatePicker/blob/master/screenshot.gif?raw=true" alt="Screenshot" width="358"/>

[![CI Status](https://img.shields.io/travis/fpotter/ExpandingDatePicker.svg?style=flat)](https://travis-ci.org/fpotter/ExpandingDatePicker)
[![Version](https://img.shields.io/cocoapods/v/ExpandingDatePicker.svg?style=flat)](https://cocoapods.org/pods/ExpandingDatePicker)
[![License](https://img.shields.io/cocoapods/l/ExpandingDatePicker.svg?style=flat)](https://cocoapods.org/pods/ExpandingDatePicker)
[![Platform](https://img.shields.io/cocoapods/p/ExpandingDatePicker.svg?style=flat)](https://cocoapods.org/pods/ExpandingDatePicker)

ExpandingDatePicker is a textual date picker that will expand to show a
graphical date picker beneath it when focused.  It has the same styling
as the expandable date picker Apple uses in Calendar.app.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Deployment target of macOS 10.10+

## Installation

ExpandingDatePicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ExpandingDatePicker'
```

## Known Issues

* When the field expands to show the graphical date picker, you'll notice that the traffic lights in your app's window will turn gray.  The expansion is shown in an `NSPanel` (a special kind of `NSWindow`), and when that panel temporarily becomes the app's key window, the traffic lights go dark.  Calendar.app's version of this expanded date picker doesn't have this problem because they [use a private API](https://github.com/fpotter/ExpandingDatePicker/blob/e22f68cca110f6e9d009dbcb7c097d5b2e35021b/ExpandingDatePicker/Classes/ExpandingDatePicker.swift#L46).

## Author

Fred Potter, fpotter@gmail.com

## License

ExpandingDatePicker is available under the MIT license. See the LICENSE file for more info.

# AskParrot

[![CI Status](http://img.shields.io/travis/hrajput4@gmail.com/AskParrot.svg?style=flat)](https://travis-ci.org/hrajput4@gmail.com/AskParrot)
[![Version](https://img.shields.io/cocoapods/v/AskParrot.svg?style=flat)](http://cocoapods.org/pods/AskParrot)
[![License](https://img.shields.io/cocoapods/l/AskParrot.svg?style=flat)](http://cocoapods.org/pods/AskParrot)
[![Platform](https://img.shields.io/cocoapods/p/AskParrot.svg?style=flat)](http://cocoapods.org/pods/AskParrot)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AskParrot is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AskParrot"
```
Drop the config.json file at the root folder of your .xcproj file downloaded from the AskParrot Web Dashboard.
Add this to didFinishLaunchingWithOptions function in your AppDelegate file.
```swift
AskParrotUI.start()
```

Then to present the helpdesk from a View Controlller call :
```swift
 AskParrotUI.performSegueToHelpdesk(caller: self)
```

## Author

hrajput4@gmail.com, hemant@hatchitup.com

## License

AskParrot is available under the MIT license. See the LICENSE file for more info.

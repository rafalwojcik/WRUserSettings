# WRUserSettings
Magical User settings class for iOS

## Usage

To start using WRUserSettings just subclass ```WRUserSettings``` class and you are ready to go!!!

So every property you add to your subclass will be stored in NSUserDefaults. Default property is nil or filled by default system value for primitive types like NSInteger, BOOL, CGRect etc.

### Basic usage

To simple usage you only need add properties to header file of subclass:

```swift
class MyUserSettings: WRUserSettings {
	dynamic var shouldShowTutorial: Bool = true
	dynamic var temperatureUnit: String = "C"
	dynamic var notyficationOn: Bool = false
}
```

From now every time you set property is automatically save it in NSUserDefaults for you.

### Setting value

Your class is singleton so you should use ```+shared``` method to get instance of it:

```swift
MyUserSettings.shared.shouldShowTutorial = false
```

Class will automatically save value ```false``` to NSUserDefaults

### Getting value

To get value just get instance of class and property:

```swift
let shouldItReallyShowTutorial = MyUserSettings.shared.shouldShowTutorial
```

### Default values

To set default values just use default assigment as above. We are storing defaults in instance.

### Reset settings

If you want reset settings call anywhere method ```reset()``` on your singleton. This method iterate through all saved settings and delete it from NSUserDefaults and assign to properties default values.

### Printing description

To print description of stored values simply print your singleton. It prints only stored values so it don't show default values that you set.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build WRUserSettings 3.0.0+.

To integrate WRUserSettings into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'WRUserSettings', '~> 3.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Change log

#### 3.0.0

\- Refactored Swift 3.0 version

#### 2.0.0

\- Swift version

#### 1.0.2

\- Add ```-resetSettings``` method

\- Add simple tests

\- Example now use pod instead of imported ```WRUserSettings``` files.

#### 1.0.1

\- Added support for structures like: ```CGPoint```, ```CGRect```, ```CGSize``` etc.

\- Modify example to show ```CGPoint``` usage.

#### 1.0.0

\- Basic stuff working

## TODO

* [] Make example
* [] Tests

## Requirements

WRUserSettings requires either iOS 8.0 and above. 

## License

WRUserSettings is available under the MIT license. See the LICENSE file for more info.

## ARC

WRUserSettings uses ARC.

## Contact

[Rafał Wójcik](http://github.com/rafalwojcik) 

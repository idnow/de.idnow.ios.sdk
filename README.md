# Table of Contents
- [IDnowCoreSDK framework](#IDnowCoreSDK-framework)
- [Installation](#installation)
  - [CocoaPods](#CocoaPods)
  - [Carthage ](#Carthage )
- [Usage](#Usage)
- [Usage example](#Usage-example)




## IDnowCoreSDK framework

The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps.
The framework itself contains `armv7` and `arm64` architectures. Since Apple does not allow to include not used architectures  into an app this framework does not include the simulator architectures. If these are needed for development purposes please contact IDnow.



## Installation

### CocoaPods 

The IDnow framework depends on the presence of several other frameworks. The current build tool used is `cocoapods`. That means in order to build an app using the framework it is necessary to add a podfile to the top-level folder of your app project. 
#### Podfile used to build the current IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
platform :ios, '10.0'
pod 'Alamofire', '~> 4.7', :inhibit_warnings => true
pod 'AlamofireLogger'
pod 'Starscream', '3.1.0'
pod 'OpenCV2', '~> 3.4.1'
pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '4.1.0'
pod 'lottie-ios'
end
```

#### Using the framework

* Put IDNowSDKCore.Framework in the app folder 
* XCode -> Target -> General -> Embedded Frameworks and Libraries -> Add IDNowSDKCore.Framework
* Insert SDK calling code in your app 
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 
* Compile & Run

### Carthage 

* Create a Cartfile 
* Add the following to the Cartfile: (Xcode 10.2)
```
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/IDNowSDKCore-Xcode-10.2.json"
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/OpenCV2.json"
github "Alamofire/Alamofire" "4.8.2"
github "getsentry/sentry-cocoa" "4.1.0"
github "daltoniam/Starscream"  "3.1.0"
```
* Add the following to the Cartfile: (Xcode 11.1)
```
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/IDNowSDKCore-Xcode-11.1.json"
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/OpenCV2.json"
github "Alamofire/Alamofire" "4.8.2"
github "getsentry/sentry-cocoa" "4.1.0"
github "daltoniam/Starscream"  "3.1.0"
```
* Add the following to the Cartfile: (Xcode 11.2.1 and above) 
```
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/IDNowSDKCore-Xcode-11.2.1.json"
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/OpenCV2.json"
github "Alamofire/Alamofire" "4.8.2"
github "getsentry/sentry-cocoa" "4.1.0"
github "daltoniam/Starscream"  "3.1.0"
```

* Run:
```
carthage update --platform iOS
```

* Drag the Frameworks needed (IDNowSDKCore.framework/ Alamofire.framework / Sentry.framework/opencv2.framework/Starscream.framework) from the Carthage/Build/iOS subfolder to ‘Linked Frameworks and Libraries’ (Target configuration -> General tab)


* Under Buid Phases tab, add a new Run Script Phase

* In the Shell text field, type : /usr/local/bin/carthage copy-frameworks

* Under Input Files add: 
```
$(SRCROOT)/Carthage/Build/iOS/IDNowSDKCore.framework
$(SRCROOT)/Carthage/Build/iOS/Alamofire.framework
$(SRCROOT)/Carthage/Build/iOS/Sentry.framework
$(SRCROOT)/Carthage/Build/iOS/Starscream.framework


```  



* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 

* Insert SDK calling code in your app

* Compile & Run


## Usage

### Starting an automated ident

The API to start an automated Ident is:
```
public func start(token: String, preferredLanguage: String = default, fromViewController: UIViewController, listener: @escaping IDNowSDKResultListener)
```

* the token needs to be all uppercase character only and should conform to the following regular expression  `.{3}-.{5}$`
* setting the prefferedLanguage (optional) tells the SDK in which language the AutoIdent UI should be shown. If the language is not available the framework first tries the language of the device and if that is not available it falls back to English.
  These ISO 639-1 language codes are currently supported: bg (Bulgarian), cs (Czech), da (Danish), de (German), el (Greek), en (English), es (Spanish), et (Estonian), fi (Finnish), fr (French), hr (Croatian), hu (Hungarian), it (Italian), ja (Japanese), ka (Georgian), ko (Korean), lt (Lithuanian), lv (Latvian), nb (Norwegian), nl (Dutch), pl (Polish), pt (Portuguese), ro (Romanian), ru (Russian), sk (Slovak), sl (Slovenian), sr (Serbian), sv (Swedish), tr (Turkish), zh (Chinese).
  
* the calling view controller
* an IDnowResultListener which gets called once the SDK returns. The possible return codes are:
** FINISHED the ident was finished
** CANCELLED the user cancelled the ident
** ERROR an error occurred (e.g. wrong token format, token invalid or incorrect, no internet connection)

### Usage example

Swift

```

IDNowSDK.shared.start(token: token, preferredLanguage:"en", fromViewController: self, listener:{ (result: IDNowSDK.IdentResult, message: String) in
           if result == IDNowSDK.IdentResult.ERROR {
               self.showAlert(text: message)
           } else if result == IDNowSDK.IdentResult.FINISHED {
           
           }
       })

```

Objective-C

```
IDNowSDK* sdk = [[IDNowSDK alloc] init];

void (^idnowResultListener)(enum IdentResult identResult, NSString * _Nonnull) = ^(enum IdentResult result, NSString* message) {
    NSLog( @"SDK finished");

    if (result == IdentResultERROR) {
        // show result in debug log
    }

    if( result == IdentResultFINISHED ) {
        // show result in debug log
    }
};

[sdk startWithToken:@"INTERNAL_TOKEN" preferredLanguage:@"en" fromViewController:self listener:idnowResultListener];

```

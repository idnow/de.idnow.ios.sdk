# :package: Swift Package Manager :package:

Since SDK version 4.15.0 (Xcode 13.2) we added support for swift package manager by providing the corresponding xcframeworks as binary targets. To integrate via Swift Package Manager please open the repository link and follow the instructions of the documentation:

[https://github.com/idnow/de.idnow.ios.sdk.spm](https://github.com/idnow/de.idnow.ios.sdk.spm) :package:

<br>

In case you use the fat framework (SDK version <= 4.14.0) you can follow the instructions below or directly in the documentation of the chosen SDK folder.


# Table of Contents
- [IDnowCoreSDK framework](#IDnowCoreSDK-framework)
- [Installation](#installation)
  - [CocoaPods](#CocoaPods)
  - [Carthage ](#Carthage )
- [Usage](#Usage)
- [Usage example](#Usage-example)




## IDnowCoreSDK framework

The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps.


## Installation

### CocoaPods 

[![Watch the video](https://github.com/idnow/de.idnow.ios.sdk/blob/master/docs/screen_shot.png)](https://youtu.be/AXwvAdt1NA4)

The IDnow framework depends on the presence of several other frameworks. The current build tool used is `cocoapods`. That means in order to build an app using the framework it is necessary to add a podfile to the top-level folder of your app project. 
#### Podfile used to build the current IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
  platform :ios, '10.0'
  pod 'OpenCV2', '~> 3.4.1'
end
```
Other than the above pods, we are using a new Liveness technology, therefore The IDnow framework is also dependent on the presence of  FaceTecSDK.framework. 

Download the framework : 

```
https://downloads.idnow.de/ios/FaceTecSDK.framework.zip

```

#### Using the framework

* Put IDNowSDKCore.Framework in the app folder as well as FaceTecSDK.framework
* XCode -> Target -> General -> Frameworks, Libraries and Embedded Content -> Add IDNowSDKCore.Framework and FaceTecSDK.framework, check Embed and Sign for both
* Insert SDK calling code in your app 
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 
* Compile & Run

### Carthage 

[![Watch the video](https://github.com/idnow/de.idnow.ios.sdk/blob/master/docs/ScreenShot2.png)](https://youtu.be/5UW1bHwpQy8)

* Create a Cartfile 

* Add the following to the Cartfile: 
```
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/IDNowSDK_4.14.0.json"
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/FaceTec.json"
binary "https://raw.githubusercontent.com/idnow/de.idnow.ios.sdk/master/OpenCV2.json"

```



* Run:
```
carthage update --platform iOS
```

* XCode -> Target -> General -> Frameworks, Libraries and Embedded Content -> Add  the Frameworks needed (IDNowSDKCore.framework /opencv2.framework /FaceTecSDK.framework) from the Carthage/Build/iOS subfolder. 


* Under Buid Phases tab, add a new Run Script Phase

* In the Shell text field, type : /usr/local/bin/carthage copy-frameworks

* Under Input Files add: 
```
$(SRCROOT)/Carthage/Build/iOS/IDNowSDKCore.framework
$(SRCROOT)/Carthage/Build/iOS/FaceTecSDK.framework
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

* The token needs to be all uppercase character only and should conform to the following regular expression  `.{3}-.{5}$`
* Setting the prefferedLanguage (optional) tells the SDK in which language the AutoIdent UI should be shown. If the language is not available the framework first tries the language of the device and if that is not available it falls back to English.
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


void (^idnowResultListener)(enum IdentResult identResult, NSString * _Nonnull) = ^(enum IdentResult result, NSString* message) {
    NSLog( @"SDK finished");

    if (result == IdentResultERROR) {
        // show result in debug log
    }

    if( result == IdentResultFINISHED ) {
        // show result in debug log
    }
};

[IDNowSDK.shared startWithToken:@"INTERNAL_TOKEN" preferredLanguage:@"en" fromViewController:self listener:idnowResultListener];

```

# Table of Contents
- [IDnowCoreSDK framework](#IDnowCoreSDK-framework)
- [Installation](#installation)
  - [CocoaPods](#CocoaPods)
  - [Carthage ](#Carthage )
- [Usage](#Usage)
- [Usage example](#Usage-example)
- [Changelog](#changelog)




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
pod 'Starscream', '~> 3.0.2'
pod 'SwiftMsgPack', '~> 1.0.0'
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

* Create Cartfile 
* Add the following to Cartfile : (Xcode 10.2)
```
github "idnow/de.idnow.ios.sdk" "3.13.0"
github "Alamofire/Alamofire" "4.8.2"
github "getsentry/sentry-cocoa" "4.1.0"

```
* Add the following to Cartfile : (Xcode 11)
```
github "idnow/de.idnow.ios.sdk" "3.13.0-Xcode11"
github "Alamofire/Alamofire" "4.8.2"
github "getsentry/sentry-cocoa" "4.1.0"

```

* Run carthage update --platform iOS

* Drag the Frameworks needed (IDNowSDKCore.framework/ Alamofire.framework / Sentry.framework) from the Carthage/Build/iOS subfolder to ‘Linked Frameworks and Libraries’ (Target configuration -> General tab)

* Make sure that under Build Settings that Framework Search Path includes $(PROJECT_DIR)/Carthage/Build/iOS 

* Under Buid Phases tab, add a new Run Script Phase

* In the Shell text field, type : /usr/local/bin/carthage copy-frameworks

* Under Input Files add : 
```
$(SRCROOT)/Carthage/Build/iOS/IDNowSDKCore.framework
$(SRCROOT)/Carthage/Build/iOS/Alamofire.framework
$(SRCROOT)/Carthage/Build/iOS/Sentry.framework

```  
* Check the (Run Script only when installing)

* Under Buid Phases tab, add a new Copy Files Phase

* For destination select Frameworks

* Drop the frameworks in the drop target, Make sure that Copy items if needed is checked, and also Code Sign On Copy is checked

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
* the calling view controller
* an IDnowResultListener which gets called once the SDK returns. The possible return codes are:
** FINISHED the ident was finished
** CANCELLED the user cancelled the ident
** ERROR an error occurred (e.g. wrong token format, token invalid or incorrect, no internet connection)

### Usage example

Swift

```
IDNowSDK.shared.start(token: tokenTextField!.text!, fromViewController: self, listener:
{ (result: IDNowSDK.IdentResult, message: String) in

print ("SDK finished")
self.progress.isHidden = true
self.progress.stopAnimating()

if (result == IDNowSDK.IdentResult.ERROR) 
{
self.showAlert(text: message)
}
}
```

Objective-C

```
IDNowSDK* sdk = [[IDNowSDK alloc] init];

void (^idnowResultListener)(enum IdentResult identResult, NSString * _Nonnull) =
^(enum IdentResult result, NSString* message) {
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

## Changelog

### 3.13.0  
Changes:
-  Feedback to the user during the identification process if : 
   - the ID document text is not read out correctly by system
   - the person's photo in the document is not clearly visible
   
- Gender readout from MRZ for all documents
- Minor improvements & bugfixes

### 3.12.0  
Changes:
-  Scanning bars added in the app in the following steps :
   - OCR - Before the segmentation
   - Security feature - Before the tracking
   - Selfie - During the selfie-taking process
   - Liveness - During the picture-taking process
   
- Changes in the arrows during the liveness step to ensure that the user understands how to turn head
- Show date format in OCR review screen based on the device language
- Minor improvements & bugfixes


### 3.11.0  
Changes:
- User can continue with identification process after the app has been put to the background
- Global document : User can finish the process of identification with any country's identity document
- Minor improvements & bugfixes

### 3.10.0  
Changes:
- UI Improvements :
   - Added spinner for results verification screen
   - Terms and Condition page layout adjustements
   - Analyzing screen improvements
   - Changes in the intro screen alignment
   - Changes in the instruction screen alignment

- Minor improvements & bugfixes

### 3.9.0  
Changes:
- Randomness in liveness detection
- Autoclassfication is supported for 19 more documents
- Minor improvements & bugfixes


### 3.8.0  
Changes:
- Improvement in the text in English, German, French, Polish and Spanish
- Minor improvements & bugfixes





## IDnowCoreSDK framework without NFC  (4.11.0) :
The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps. 


### Dependencies

The IDnow framework depends on the presence of several other frameworks. The current build tool used is `cocoapods`. That means in order build an app using the framework it is neccessary to add a podfile to the toplevel folder of your app project. Please note that we replaced Alamofire with URLSession.
This is the Podfile used to build the current IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
platform :ios, '10.0'
pod 'OpenCV2', '~> 3.4.1'
end
```
Other than the above pods, we are using a new Liveness technology, therefore The IDnow framework is also dependent on the presence of FaceTecSDK.framework

Downlaod the framework :
```
https://downloads.idnow.de/ios/FaceTecSDK.framework.zip

```


### Using the framework

* Put IDNowSDKCore.Framework in the app folder as well as FaceTecSDK.framework
* XCode -> Target -> General -> Frameworks, Libraries and Embedded Content -> Add IDNowSDKCore.Framework and FaceTecSDK.framework, check Embed and Sign for both
* Go to Pods, then under Targets look for OpenCV2, under Build Settings set Build Libraries for Distribution for the pods to Yes, Otherwise you’ll get dyld: Symbol not found error at runtime.
* Insert SDK calling code in your app
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 
* Compile & Run


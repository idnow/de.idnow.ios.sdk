## IDnowCoreSDK framework
The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps. The framework itself contains `armv7` and `arm64` architectures. Since Apple does not allow to include not used architectures into an app this framework does not include the simulator architectures. If these are needed for development purposes please contact IDnow.


### Dependencies

The IDnow framework depends on the presence of several other frameworks. The current build tool used is `cocoapods`. That means in order build an app using the framework it is neccessary to add a podfile to the toplevel folder of your app project. This is the Podfile used to build the current
IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
platform :ios, '10.0'
pod 'Alamofire', '~> 4.7', :inhibit_warnings => true
pod 'Starscream', '3.1.0'
pod 'OpenCV2', '~> 3.4.1'
pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '4.1.0'
end
```

### Using the framework

* Put IDNowSDKCore.Framework in the app folder 
* XCode -> Target -> General -> Embedded Frameworks and Libraries -> Add IDNowSDKCore.Framework
* Go to Pods, then under Targets look for Alamofire, OpenCV2, Sentry and Starscream, under Build Settings set Build Libraries for Distribution for the pods to Yes, Otherwise you’ll get dyld: Symbol not found error at runtime.
* Insert SDK calling code in your app
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 
* Compile & Run


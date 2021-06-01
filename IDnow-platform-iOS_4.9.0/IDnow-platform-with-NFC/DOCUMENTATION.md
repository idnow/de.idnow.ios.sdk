## IDnowCoreSDK framework with NFC  (4.9.0)
The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps. 

#### This version of IDnowCoreSDK is dependent on the presence of ReadID frameworks.


### New Feature: Reading NFC chip of electronic IDs & Passports and validating their authenticity

By leveraging the NFC capability (Near Field Communication), our SDK can now read out the data of the NFC chips of electronic IDs & Passports which adds an extra layer of security to digital identity verification. This will speed boost the identity verification process and increase the level of fraud protection.
We support ICAO 9303 documents (passports, ID cards, residence permits) : please reach out to IDnow for more information.


### Dependencies

The IDnow framework depends on the presence of several frameworks. The current build tool used is `cocoapods`. That means in order to build an app using the framework it is neccessary to add a podfile to the toplevel folder of your app project. 
This is the Podfile used to build the current IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
platform :ios, '10.0'
pod 'OpenCV2', '~> 3.4.1'
pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '4.1.0'
end
```
Other than the above pods, The IDnow framework is dependent on the presence of FaceTecSDK.framework

Downlaod the framework :
```
https://downloads.idnow.de/ios/FaceTecSDK.framework.zip

```
The IDnow framework is also dependent on the presence of ReadID_UI.xcframework and ReadID.xcframework,  please reach out to IDnow to obtain these XCFrameworks. 


### Using the framework

* Put IDNowSDKCore.Framework,  FaceTecSDK.framework, ReadID_UI.xcframework and ReadID.xcframework in the app folder
* XCode -> Target -> General -> Frameworks, Libraries and Embedded Content -> Add IDNowSDKCore.Framework, FaceTecSDK.framework, ReadID_UI.xcframework and ReadID.xcframework  and check Embed and Sign.
* Go to Pods, then under Targets look for OpenCV2 and Sentry, under Build Settings set Build Libraries for Distribution for the pods to Yes, Otherwise you’ll get dyld: Symbol not found error at runtime.
* On the Signing & Capabilities configuration tab add the Capability ‘Near Field Communication Tag Reading’
* Add ‘NFCReaderUsageDescription’ to your App’s Info.plist file 
* Copy the snippet below into your App’s Info.plist file 
```
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key> <array>
<string>A0000002471001</string>
<string>A00000045645444C2D3031</string>
</array>

```
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your App's .plist file 
* Insert SDK calling code in your app
* Compile & Run


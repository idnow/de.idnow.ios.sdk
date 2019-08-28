# IDnowCoreSDK framework

The IDnow framework can be used to incorporate the IDnow AutoIdent platform into iOS Objective C or Swift apps.
The framework itself contains `armv7` and `arm64` architectures. Since Apple does not allow to include not used architectures  into an app this framework does not include the simulator architectures. If these are needed for development purposes please contact IDnow.

### Dependencies

The IDnow framework depends on the presence of several other frameworks. The current build tool used is `cocoapods`. That means in order to build an app using the framework it is necessary to add a podfile to the top-level folder of your app project. This is the Podfile used to build the current
IDnow AutoIdent iOS app:

```
workspace 'AutoIdent.xcworkspace'
platform :ios, '10.0'
use_frameworks!

target 'AutoIdent' do
platform :ios, '10.0'
pod 'Alamofire', '~> 4.7', :inhibit_warnings => true
pod 'OpenCV2', '~> 3.4.1'
pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '4.1.0'
end
```

### Using the framework

* Put IDNowSDKCore.Framework in the app folder 
* XCode -> Target -> General -> Embedded Frameworks and Libraries -> Add IDNowSDKCore.Framework
* Insert SDK calling code in your app 
* Add NSCameraUsageDescription and NSPhotoLibraryUsageDescription keys in your app's .plist file 
* Compile & Run

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




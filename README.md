# traveltime

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Splash

https://pub.dev/packages/flutter_native_splash

```
flutter gen-l10n
dart run build_runner build
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

## iOS 
```
xcode clean cache before archive
shift + cmd + k
flutter build ipa
```


## Android

1. Add `keystore.properties` file
```
storePassword=ruptela
keyPassword=ruptela
keyAlias=ontrack
storeFile=../OnTrack.jks
```

2. Add `xxxxxxxxxx.jks` file
3. Build
```
flutter build apk --split-per-abi --obfuscate --split-debug-info=.tmp
flutter build appbundle --obfuscate --split-debug-info=.tmp
flutter run --release
```


```
keytool -genkey -v -keystore android/traveltime_upload.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
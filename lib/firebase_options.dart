// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvEcU2Y_dtvgr-rHXi4eYgD6hzPJATJ5E',
    appId: '1:756419448869:web:0db57d3342489373c16fcc',
    messagingSenderId: '756419448869',
    projectId: 'f3-demo-proj',
    authDomain: 'f3-demo-proj.firebaseapp.com',
    storageBucket: 'f3-demo-proj.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoJnNlnRzD1yygLF5v5MyDG1FgOzklw3Q',
    appId: '1:756419448869:android:ad80771d19f360bac16fcc',
    messagingSenderId: '756419448869',
    projectId: 'f3-demo-proj',
    storageBucket: 'f3-demo-proj.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvFx1o1QcZ_ohlz-OxLN_hl1OvXe8fZLs',
    appId: '1:756419448869:ios:5b35eea1c099ce05c16fcc',
    messagingSenderId: '756419448869',
    projectId: 'f3-demo-proj',
    storageBucket: 'f3-demo-proj.appspot.com',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvFx1o1QcZ_ohlz-OxLN_hl1OvXe8fZLs',
    appId: '1:756419448869:ios:bacaa361cf6112e5c16fcc',
    messagingSenderId: '756419448869',
    projectId: 'f3-demo-proj',
    storageBucket: 'f3-demo-proj.appspot.com',
    iosBundleId: 'com.example.myapp.RunnerTests',
  );
}

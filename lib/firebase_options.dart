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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJIHszZ4BzHFLo6BLKcIBTxLKR0hXJNFA',
    appId: '1:1033711817800:android:aa97f30b789ca0e1eff47d',
    messagingSenderId: '1033711817800',
    projectId: 'corpo-2f513',
    storageBucket: 'corpo-2f513.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkAxXqE0JqRF0Gx7rMkJhnZ28ILAH1tN4',
    appId: '1:1033711817800:ios:7ed0edbcf627b578eff47d',
    messagingSenderId: '1033711817800',
    projectId: 'corpo-2f513',
    storageBucket: 'corpo-2f513.appspot.com',
    androidClientId: '1033711817800-hhihfmcr110usfsmjin8t6pu2rv6qk82.apps.googleusercontent.com',
    iosClientId: '1033711817800-m34i608iodj5egdflen3dkahpc380jo2.apps.googleusercontent.com',
    iosBundleId: 'com.nichemarabu.corpo',
  );
}

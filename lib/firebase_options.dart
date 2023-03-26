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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDMeuatwShsz_EHFqMBAT5O7daYFQJ-sn0',
    appId: '1:456705677442:web:7ce55eecae782609653c9b',
    messagingSenderId: '456705677442',
    projectId: 'socialsample-1ebb0',
    authDomain: 'socialsample-1ebb0.firebaseapp.com',
    storageBucket: 'socialsample-1ebb0.appspot.com',
    measurementId: 'G-2P6MNNLXWY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvDQZ5U5BO6Dv6FQDDbh295eTLiF6cvu8',
    appId: '1:456705677442:android:11a57cd80f4ea302653c9b',
    messagingSenderId: '456705677442',
    projectId: 'socialsample-1ebb0',
    storageBucket: 'socialsample-1ebb0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBL0YOFxBydgVXtSH1c-gKq3Ufyls-o88o',
    appId: '1:456705677442:ios:02c5ed30de776a5f653c9b',
    messagingSenderId: '456705677442',
    projectId: 'socialsample-1ebb0',
    storageBucket: 'socialsample-1ebb0.appspot.com',
    iosClientId: '456705677442-5tfavekfcehlnjeluk1j9sq72crankja.apps.googleusercontent.com',
    iosBundleId: 'com.example.fireapp',
  );
}
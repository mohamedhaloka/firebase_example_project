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
    apiKey: 'AIzaSyD6BygTkHMNmJWLNIzvufn9x1Ar6B_gqyE',
    appId: '1:576298614511:web:d306d5a0ea5fa860d6251a',
    messagingSenderId: '576298614511',
    projectId: 'eye-can-60b59',
    authDomain: 'eye-can-60b59.firebaseapp.com',
    storageBucket: 'eye-can-60b59.appspot.com',
    measurementId: 'G-366MLB5M1N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBY2IGYrnkkx4ELlKoH--JRm5OXC0KRkgY',
    appId: '1:576298614511:android:baf17afb6f77e85ed6251a',
    messagingSenderId: '576298614511',
    projectId: 'eye-can-60b59',
    storageBucket: 'eye-can-60b59.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2hZ8OdFiwNjCOCx0QzPKwZRzlXCsWP8o',
    appId: '1:576298614511:ios:348203d0a4494915d6251a',
    messagingSenderId: '576298614511',
    projectId: 'eye-can-60b59',
    storageBucket: 'eye-can-60b59.appspot.com',
    iosClientId: '576298614511-papp5plukmq4c0c4tc6ofcjf053jioic.apps.googleusercontent.com',
    iosBundleId: 'com.eye.eyeCan',
  );
}
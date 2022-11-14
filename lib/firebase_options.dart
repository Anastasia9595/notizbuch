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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7Zeg_Qexez3ohiCkyPpsbEliJWuSx7bE',
    appId: '1:1042076449521:android:b3a2d4fe3b3dec61ce4750',
    messagingSenderId: '1042076449521',
    projectId: 'notes-97db3',
    storageBucket: 'notes-97db3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrH7MW0uwCNZBZ5ry9I-90oAs72o4UIKk',
    appId: '1:1042076449521:ios:7c38617fb21a75acce4750',
    messagingSenderId: '1042076449521',
    projectId: 'notes-97db3',
    storageBucket: 'notes-97db3.appspot.com',
    iosClientId: '1042076449521-otv5mi839r34jrr97amno46ku6052rh6.apps.googleusercontent.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrH7MW0uwCNZBZ5ry9I-90oAs72o4UIKk',
    appId: '1:1042076449521:ios:02630c8b91ad3b16ce4750',
    messagingSenderId: '1042076449521',
    projectId: 'notes-97db3',
    storageBucket: 'notes-97db3.appspot.com',
    iosClientId: '1042076449521-b0tc8mo4kt6gq7pfud547r6gl55pfr3u.apps.googleusercontent.com',
    iosBundleId: 'com.notes.app',
  );
}

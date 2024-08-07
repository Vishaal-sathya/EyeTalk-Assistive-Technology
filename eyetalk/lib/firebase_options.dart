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
    apiKey: 'AIzaSyCP6XM17FLT7V11YbKGCYwQGp1-HJuDY2w',
    appId: '1:344960967948:web:82b3fa158f400345119529',
    messagingSenderId: '344960967948',
    projectId: 'smarthome-310c5',
    authDomain: 'smarthome-310c5.firebaseapp.com',
    databaseURL: 'https://smarthome-310c5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smarthome-310c5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu7x7hCCxIHVm4JJq2kiMsCJndyI-dtl0',
    appId: '1:344960967948:android:80626b7425bebfe9119529',
    messagingSenderId: '344960967948',
    projectId: 'smarthome-310c5',
    databaseURL: 'https://smarthome-310c5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smarthome-310c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjly401hoSsOnd1wtU5EpOHVYPpWiuSwU',
    appId: '1:344960967948:ios:51eebae694b847ff119529',
    messagingSenderId: '344960967948',
    projectId: 'smarthome-310c5',
    databaseURL: 'https://smarthome-310c5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smarthome-310c5.appspot.com',
    iosBundleId: 'com.example.smarthome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjly401hoSsOnd1wtU5EpOHVYPpWiuSwU',
    appId: '1:344960967948:ios:74c7b229621f6df5119529',
    messagingSenderId: '344960967948',
    projectId: 'smarthome-310c5',
    databaseURL: 'https://smarthome-310c5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'smarthome-310c5.appspot.com',
    iosBundleId: 'com.example.smarthome.RunnerTests',
  );
}
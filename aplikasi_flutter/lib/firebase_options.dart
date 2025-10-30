import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Platform ini tidak didukung Firebase');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9uUiXUigWBwBOxeS87kcEaPcEoPDMhog',
    appId: '1:938447450518:android:8ea8ecc416a14dd337edb7',
    messagingSenderId: '938447450518',
    projectId: 'aplikasiku-4f51d',
    storageBucket: 'aplikasiku-4f51d.firebasestorage.app',
  );

  /// Konfigurasi Android

  /// Konfigurasi iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_IOS_MESSAGING_SENDER_ID',
    projectId: 'aplikasi_flutter',
    storageBucket: 'aplikasi_flutter.appspot.com',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDcfCOIRLI-TU8rbum3ujNOhA__OEndAO0',
    appId: '1:938447450518:web:dd7f0439458e5eda37edb7',
    messagingSenderId: '938447450518',
    projectId: 'aplikasiku-4f51d',
    authDomain: 'aplikasiku-4f51d.firebaseapp.com',
    storageBucket: 'aplikasiku-4f51d.firebasestorage.app',
    measurementId: 'G-BQ4X6BNPXV',
  );

  /// Konfigurasi Web
}
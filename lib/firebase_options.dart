
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
        return windows;
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
    apiKey: 'AIzaSyABJtZXTfQ-7jljwiSvoNeQnGvU_gAZbyE',
    appId: '1:787774277405:web:362cd239c57210e25c83f4',
    messagingSenderId: '787774277405',
    projectId: 'final-swiftfeed',
    authDomain: 'final-swiftfeed.firebaseapp.com',
    storageBucket: 'final-swiftfeed.appspot.com',
    measurementId: 'G-RBVGPCB8K2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARm3UTb4sB7STcsyrqIPe_9mAgINYm-lY',
    appId: '1:787774277405:android:0148c244f118d5765c83f4',
    messagingSenderId: '787774277405',
    projectId: 'final-swiftfeed',
    storageBucket: 'final-swiftfeed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCv5vuxIrrI5758GyY4ZcJmwRHb5zUwcjA',
    appId: '1:787774277405:ios:cd6249623aa18d635c83f4',
    messagingSenderId: '787774277405',
    projectId: 'final-swiftfeed',
    storageBucket: 'final-swiftfeed.appspot.com',
    iosBundleId: 'com.example.finalapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCv5vuxIrrI5758GyY4ZcJmwRHb5zUwcjA',
    appId: '1:787774277405:ios:cd6249623aa18d635c83f4',
    messagingSenderId: '787774277405',
    projectId: 'final-swiftfeed',
    storageBucket: 'final-swiftfeed.appspot.com',
    iosBundleId: 'com.example.finalapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyABJtZXTfQ-7jljwiSvoNeQnGvU_gAZbyE',
    appId: '1:787774277405:web:f8981183a893a7c65c83f4',
    messagingSenderId: '787774277405',
    projectId: 'final-swiftfeed',
    authDomain: 'final-swiftfeed.firebaseapp.com',
    storageBucket: 'final-swiftfeed.appspot.com',
    measurementId: 'G-RNSQRML13Q',
  );

}
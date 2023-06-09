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
    apiKey: 'AIzaSyCOBxr_FCLbfKJLjMk_PtQS6F5vTxV-7-s',
    appId: '1:868597907667:web:f595ae60762721016fd426',
    messagingSenderId: '868597907667',
    projectId: 'todo-f4d4b',
    authDomain: 'todo-f4d4b.firebaseapp.com',
    storageBucket: 'todo-f4d4b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADuRBGLK1c9s0GLt2VsSGj1XuxBw6txlw',
    appId: '1:868597907667:android:4c9d49c3dfad20096fd426',
    messagingSenderId: '868597907667',
    projectId: 'todo-f4d4b',
    storageBucket: 'todo-f4d4b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFCWjdl0-60J2bCe_VnZOa-GsVlTAc8os',
    appId: '1:868597907667:ios:2699737d689ab9ca6fd426',
    messagingSenderId: '868597907667',
    projectId: 'todo-f4d4b',
    storageBucket: 'todo-f4d4b.appspot.com',
    iosClientId: '868597907667-qm5e9ocv4t1liraai9h4p2vvrdnuf13c.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFCWjdl0-60J2bCe_VnZOa-GsVlTAc8os',
    appId: '1:868597907667:ios:2699737d689ab9ca6fd426',
    messagingSenderId: '868597907667',
    projectId: 'todo-f4d4b',
    storageBucket: 'todo-f4d4b.appspot.com',
    iosClientId: '868597907667-qm5e9ocv4t1liraai9h4p2vvrdnuf13c.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoapp',
  );
}

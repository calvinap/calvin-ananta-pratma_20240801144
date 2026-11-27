import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// File konfigurasi Firebase sementara (placeholder).
/// Jalankan perintah `flutterfire configure` di folder `tugas_pertemuan5`
/// untuk mengganti file ini secara otomatis dengan konfigurasi project Firebase Anda.
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
          'DefaultFirebaseOptions belum dikonfigurasi untuk Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions tidak mendukung platform ini.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAENdVMWmFLJwwfdTmbkQV1Seggmaq6yjU',
    appId: '1:1003367473992:web:d92c81143baf1a7ecc897d',
    messagingSenderId: '1003367473992',
    projectId: 'stok-barang-af8ef',
    authDomain: 'stok-barang-af8ef.firebaseapp.com',
    storageBucket: 'stok-barang-af8ef.firebasestorage.app',
    measurementId: 'G-CYFHDT478N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_ANDROID_API_KEY',
    appId: 'REPLACE_WITH_YOUR_ANDROID_APP_ID',
    messagingSenderId: 'REPLACE_WITH_YOUR_MESSAGING_SENDER_ID',
    projectId: 'REPLACE_WITH_YOUR_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_YOUR_PROJECT_ID.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_IOS_API_KEY',
    appId: 'REPLACE_WITH_YOUR_IOS_APP_ID',
    messagingSenderId: 'REPLACE_WITH_YOUR_MESSAGING_SENDER_ID',
    projectId: 'REPLACE_WITH_YOUR_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_YOUR_PROJECT_ID.firebasestorage.app',
    iosBundleId: 'com.example.tugasPertemuan5',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_MACOS_API_KEY',
    appId: 'REPLACE_WITH_YOUR_MACOS_APP_ID',
    messagingSenderId: 'REPLACE_WITH_YOUR_MESSAGING_SENDER_ID',
    projectId: 'REPLACE_WITH_YOUR_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_YOUR_PROJECT_ID.firebasestorage.app',
    iosBundleId: 'com.example.tugasPertemuan5',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAENdVMWmFLJwwfdTmbkQV1Seggmaq6yjU',
    appId: '1:1003367473992:web:d92c81143baf1a7ecc897d',
    messagingSenderId: '1003367473992',
    projectId: 'stok-barang-af8ef',
    authDomain: 'stok-barang-af8ef.firebaseapp.com',
    storageBucket: 'stok-barang-af8ef.firebasestorage.app',
    measurementId: 'G-CYFHDT478N',
  );
}

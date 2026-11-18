import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  static Future<void> initNotification() async {
    final fcm = FirebaseMessaging.instance;

    // 1. Meminta izin notifikasi kepada pengguna (wajib untuk Android 13+)
    final settings = await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Status Izin Notifikasi: ${settings.authorizationStatus}');

    // 2. Mengambil Token FCM unik dari perangkat ini
    final token = await fcm.getToken();

    // Sengaja digabung dalam satu baris agar tidak dipotong oleh filter Logcat
    print('FCM TOKEN: $token');
  }
}
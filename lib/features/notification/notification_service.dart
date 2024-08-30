import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grock/grock.dart';

class NotificationService {
  late final FirebaseMessaging _firebaseMessaging;

  NotificationService() {
    _firebaseMessaging = FirebaseMessaging.instance;
  }

  // Bildirim izni isteme
  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  void initialize() async {
    await _requestPermission();

    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

// Uygulama ön plandayken gelen bildirimleri dinleme
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Grock.snackBar(
        title: message.notification?.title ?? 'No Title',
        description: message.notification?.body ?? 'No Body',
        opacity: 0.5,
        position: SnackbarPosition.top,
      );
      print("Mesaj alındı: ${message.notification?.title}");
    });

    // Bildirimlere tıklama olaylarını dinleme
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Bildirim ile uygulama açıldı!');
    });

    // FCM Token alma
    _firebaseMessaging.getToken().then((value) {
      if (value != null) {
        print("Firebase Token: $value");
      }
    });
  }

  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print("Background Message: ${message.messageId}");
  }
}

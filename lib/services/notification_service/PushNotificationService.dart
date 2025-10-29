import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialise() async {
    // iOS için izin isteği (bu kodu ihtiyaç duyulursa açabilirsiniz)
    /*if (Platform.isIOS) {
      await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }*/

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.messageId}");
      // Burada mesajın içeriğini işleyebilirsiniz
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.messageId}");
      // Uygulama arka plandayken tıklanırsa yapılacak işlemler
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("onBackgroundMessage: ${message.messageId}");
    // Arka planda gelen mesajlarla ilgili yapılacak işlemler
  }
}

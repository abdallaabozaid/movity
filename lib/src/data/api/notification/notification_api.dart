import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  static final onNotificationOpen = BehaviorSubject<String?>();
  static String? selectedNotificationPayload;
  static Future showNotificaton({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payLoad,
      );

  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel Id',
        'movity app',
        channelDescription: 'channel Description',
        importance: Importance.max,
        showWhen: true,
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future<bool?> init() async {
    const android = AndroidInitializationSettings('splash');
    const ios = IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: android,
      iOS: ios,
    );
    return await _notification.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          // do whatever you wanna do
        }
        selectedNotificationPayload = payload;
        onNotificationOpen.add(payload);
      },
    );
  }
}

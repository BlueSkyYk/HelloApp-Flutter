import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  static FlutterLocalNotificationsPlugin showNotification(
      int id, String title, String content, NotificationCallback notiCallback,
      {PayloadCallback payloadCallback, String payload}) {
    var flutterLocalNotificationsPlugin =
        _initNotifications(payloadCallback: payloadCallback);
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'myChannel', 'myChannelName', 'myChannelDescription',
        importance: Importance.Max, priority: Priority.High);
    //IOS的通知配置
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //显示通知，其中 0 代表通知的 id，用于区分通知。
    flutterLocalNotificationsPlugin.show(
        id, title, content, platformChannelSpecifics,
        payload: payload == null ? payload : "onComplete");
    return flutterLocalNotificationsPlugin;
  }

  //初始化通知栏
  static FlutterLocalNotificationsPlugin _initNotifications(
      {PayloadCallback payloadCallback}) {
    var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        //IOS端接收到通知所作的处理的方法
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) {
      // 展示通知内容的 dialog.
//      showDialog(
//        context: context,
//        builder: (BuildContext context) => new CupertinoAlertDialog(
//              title: new Text(title),
//              content: new Text(body),
//              actions: [
//                CupertinoDialogAction(
//                  isDefaultAction: true,
//                  child: new Text('Ok'),
//                  onPressed: () async {},
//                )
//              ],
//            ),
//      );
    });
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    //初始化通知栏
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payloadCallback != null) {
        await payloadCallback(payload);
      }
    });
    return flutterLocalNotificationsPlugin;
  }

  //删除单个通知
  static Future _cancelNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    //参数 0 为需要删除的通知的id
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  //删除所有通知
  static Future _cancelAllNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

typedef NotificationCallback = Function(
    FlutterLocalNotificationsPlugin notificationPlugin);
typedef PayloadCallback = Function(String payload);

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FlutterImPlugin {
  //flutter调用native通道
  static MethodChannel _channel = const MethodChannel('flutter_im_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /**
   * 初始化IM
   */
  static Future<String> initIM() async {
    final String msg = await _channel.invokeMethod("initIM");
    return msg;
  }

  /**
   * IM登录
   */
  static Future<bool> loginIM(String account, String password, String ip,
      int port) async {
    var param = {
      "account": account,
      "password": password,
      "imServerIp": ip,
      "imServerPort": port
    };
    final success = await _channel.invokeMethod("loginIM", param);
    return success;
  }

  /**
   * 退出登录
   */
  static Future<bool> logoutIM() async {
    final success = await _channel.invokeMethod("logoutIM");
    return success;
  }

  /**
   *
   */
  static Future getChatMessageList(int ) {

  }
}

//消息
class NativeEvent {
  //登录结果回调
  static const int EVENT_LOGIN_RESULT = 100;

  //消息回调
  static const int EVENT_MESSAGE = 110;

  int event;
  Map<String, dynamic> data;

  NativeEvent.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    data = json['data'];
  }
}

abstract class NativeCallFlutterPluginState<T extends StatefulWidget>
    extends State<T> {
//  StreamSubscription _nativeListener;

  BasicMessageChannel<String> _basicMessageChannel;

  //登录结果回调
  Function(bool success) _loginResultCallback;

  //消息回调
  Function(Map<String, Object>) _messageCallback;

  @override
  void initState() {
    super.initState();
    //开始监听
//    _nativeListener = EventChannel("native_call_flutter_im_plugin")
//        .receiveBroadcastStream()
//        .listen((obj) {});
    _basicMessageChannel = BasicMessageChannel<String>(
        "native_call_flutter_im_plugin", StringCodec());
    _basicMessageChannel.setMessageHandler((msgStr) {
      print("Flutter接受消息。。。。。。。。。。。。" + msgStr);
      var nativeEvent = NativeEvent.fromJson(json.decode(msgStr));
      switch (nativeEvent.event) {
        case NativeEvent.EVENT_LOGIN_RESULT: //登录结果回调
          if (_loginResultCallback != null) {
            _loginResultCallback(nativeEvent.data['success']);
          }
          break;
        case NativeEvent.EVENT_MESSAGE: //消息回调
          print("Flutter消息回调。。。。。。。。。。。。" +
              (_messageCallback == null).toString() +
              "     " +
              msgStr);
          if (_messageCallback != null) {
            _messageCallback(nativeEvent.data);
          }
      }
    });
  }

  /**
   * 设置登录回调
   */
  void setLoginResultCallback(Function(bool success) loginResultCallback) {
    this._loginResultCallback = loginResultCallback;
  }

  void setMessageCallback(Function(Map<String, Object>) messageCallback) {
    print("设置MessageCallback：" + (messageCallback == null).toString());
    this._messageCallback = messageCallback;
  }

  @override
  void dispose() {
    super.dispose();
//    if (_nativeListener != null) {
//      _nativeListener.cancel();
//    }

    _loginResultCallback = null;
    _messageCallback = null;
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_im_plugin/flutter_im_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends NativeCallFlutterPluginState<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initIM();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterImPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initIM() async {
    setLoginResultCallback((success) {
      if (success) {
        print("哈哈哈哈哈哈，登录成功");
      } else {
        print("哈哈哈哈哈，登录失败");
      }
    });
    try {
      //初始化IM
      print(await FlutterImPlugin.initIM());

      bool success = await FlutterImPlugin.loginIM(
          "Hello_at1b51hj", "", "192.168.0.149", 9000);
      if (success) {
        print("IM登录成功");
      } else {
        print("IM登录失败");
      }
    } on PlatformException {
      print("调用IM登录失败");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

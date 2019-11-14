import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_im_plugin/flutter_im_plugin.dart';
import 'package:hello_app/ui/chat/chat_page.dart';
import 'package:hello_app/ui/login/login_page.dart';

void main() {
  //注册Flutter服务

  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends NativeCallFlutterPluginState<MyApp> {
  @override
  void initState() {
    //初始化IM
    _initIM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.black87,
        cursorColor: Colors.black87,
        dividerColor: Colors.black87,
        textSelectionColor: Colors.black87,
        backgroundColor: Colors.black87,
        accentColor: Colors.black87,
        indicatorColor: Colors.black87,
        selectedRowColor: Colors.black87,
        highlightColor: Colors.black87,
        hintColor: Colors.black87,
        primaryColor: Colors.blue,
        textSelectionHandleColor: Colors.black87,
        appBarTheme: AppBarTheme(color: Colors.black87),
      ),
      home: LoginPage(),
//      home: ChatPage(),
    );
  }

  //初始化IM
  void _initIM() async {
    String msg = await FlutterImPlugin.initIM();
    debugPrint(msg);
  }
}

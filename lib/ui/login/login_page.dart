import 'package:flutter/material.dart';
import 'package:flutter_im_plugin/flutter_im_plugin.dart';
import 'package:hello_app/constants/constants.dart';
import 'package:hello_app/data/api/sms_api.dart';
import 'package:hello_app/data/api/user_api.dart';
import 'package:hello_app/data/local_data_manager.dart';
import 'package:hello_app/data/res/result.dart';
import 'package:hello_app/ui/main/mian_page.dart';
import 'package:hello_app/util/string_util.dart';
import 'package:hello_app/util/view.dart';
import 'package:quiver/strings.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends NativeCallFlutterPluginState<LoginPage> {
  TextEditingController _pPhoneController = TextEditingController();
  TextEditingController _pPasswordController = TextEditingController();
  TextEditingController _sPhoneController = TextEditingController();
  TextEditingController _sSmsController = TextEditingController();

  int _loginType = 1; //登录类型：1 密码登录，2 短信登录，3 qq登录
  String _smsTitle = "获取验证码";

  @override
  void initState() {
    super.initState();
    //检查登录
    checkLogined();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 120,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            alignment: Alignment.bottomLeft,
            child: Text(
              "快捷登录",
              style: TextStyle(fontSize: 32),
            ),
          ),
          //获取登录布局
//          _loginType == 1 ? _wPassword : _wSmsCode,
          _loginType == 1 ? getPasswordLoginWidget() : getSmsCodeLoginWidget(),
          Container(
            margin: EdgeInsets.only(top: 10, left: 34, right: 34),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  _loginType == 1 ? "验证码登录" : "密码登录",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
              ),
              onTap: () {
                setState(() {
                  if (_loginType == 1) {
                    _loginType = 2;
                  } else if (_loginType == 2) {
                    _loginType = 1;
                  }
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 34, right: 34),
            width: double.infinity,
            height: 52,
            child: RaisedButton(
              onPressed: doLogin,
              child: Text(
                "登录",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/qq.png",
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 30,
                ),
                Image.asset(
                  "assets/images/qq.png",
                  width: 50,
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //获取密码登录布局
  Widget getPasswordLoginWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 34, right: 34, top: 26),
          child: TextField(
            controller: _pPhoneController,
            maxLength: 15,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            decoration: InputDecoration(
                labelText: "手机号",
                hintText: "请输入手机号",
                hintStyle: TextStyle(color: Colors.black26)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 34, right: 34),
          child: TextField(
            controller: _pPasswordController,
            maxLength: 20,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                hintStyle: TextStyle(color: Colors.black26)),
          ),
        )
      ],
    );
  }

  //获取短信登录布局
  Widget getSmsCodeLoginWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 34, right: 34, top: 26),
          child: TextField(
            controller: _sPhoneController,
            maxLength: 15,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            decoration: InputDecoration(
                labelText: "手机号",
                hintText: "请输入手机号",
                hintStyle: TextStyle(color: Colors.black26)),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 34, right: 34),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: _sSmsController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      maxLength: 6,
                      decoration: InputDecoration(
                          hintText: "请输入验证码",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.topRight,
                    child: RaisedButton(
                      onPressed: getSMSCode,
                      child: Text(_smsTitle),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      highlightColor: Colors.lightBlue,
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  String _inputPhone;

  //获取短信验证码
  void getSMSCode() {
    var phone = _sPhoneController.text;
    //检查手机号
    if (StringUtil.checkPhone(phone)) {
      SmsApi.getSmsCode(phone, (Result result) {
        showToast(result.message);
        if (result.code == ResultCode.SUCCESS) {
          _inputPhone = phone;
          //开始倒计时
        } else {}
      }, (code, msg) {
        showToast(msg);
      });
    } else {
      showToast("请输入正确手机号");
    }
  }

  //登录
  void doLogin() {
    String phone = null;
    String smsCode = null;
    String password = null;

    int loginType = 1;
    if (_loginType == 1) {
      //密码登录
      phone = _pPhoneController.text;
      if (isEmpty(phone)) {
        showToast("请输入手机号");
        return;
      }
      password = _pPasswordController.text;
      if (isEmpty(password)) {
        showToast("请输入密码");
        return;
      }
      loginType = 1;
    } else if (_loginType == 2) {
      //短信登录
      if (isEmpty(_inputPhone)) {
        showToast("请先获取验证码");
        return;
      }
      smsCode = _sSmsController.text;
      if (isEmpty(smsCode) || smsCode.length != 6) {
        showToast("请输入六位验证码");
        return;
      }
      loginType = 2;
      phone = _inputPhone;
    } else {
      return;
    }
    //登录
    UserApi.login(loginType, phone, smsCode, password, null, (result) {
      if (result.success && result.data != null) {
        showToast("登录成功");
        //保存成功
        LocalDataManager.saveUserToLocal(result.data);
        // 登录IM
        FlutterImPlugin.loginIM(result.data.username, "",
            Constants.IM_SERVER_IP, Constants.IM_SERVER_PORT);
        //跳转主页
        skipMainPage();
      } else {
        showToast(result.message);
      }
    }, (errCode, errMsg) {
      showToast(errMsg);
    });
  }

  //检查登录
  void checkLogined() {
    LocalDataManager.getUserFromLocal((user) {
      if (user != null) {
        // 登录IM
        FlutterImPlugin.loginIM(user.username, "", Constants.IM_SERVER_IP,
            Constants.IM_SERVER_PORT);
        //跳转主页
        skipMainPage();
      }
    });
  }

  //跳转首页
  void skipMainPage() {
    //跳转到主页
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        (route) => route == null);
  }
}

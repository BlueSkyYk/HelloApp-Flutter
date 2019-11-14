import 'package:flutter/material.dart';
import 'package:hello_app/data/api/user_friend_api.dart';
import 'package:hello_app/util/view.dart';
import 'package:quiver/strings.dart';

class AddFriendVerPage extends StatefulWidget {
  @override
  _AddFriendVerPageState createState() => _AddFriendVerPageState();
}

class _AddFriendVerPageState extends State<AddFriendVerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("好友验证"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 26),
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/qq.png",
                          image:
                              "http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg",
                          width: 64,
                          height: 64,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "懒烂蓝",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: Text(
                                  "用户名:" + "Hello_FFJHGWE34",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "验证信息：",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          "请求添加好友",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "同意",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _showVerMsgDialog(true);
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        "拒绝",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _showVerMsgDialog(false);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //显示验证信息输入dialog
  void _showVerMsgDialog(bool accept) {
    int userId = 1;
    int friendId = 2;
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text("添加好友"),
          content: getInputDialogContent("验证信息", controller),
          actions: getDialogAction(context, () {
            var verMsg = controller.text;
            //发送添加好友请求
            _doAddFriendResult(accept, userId, friendId, verMsg);
          }),
        );
      },
    );
  }

  //发送添加好友结果请求
  void _doAddFriendResult(
      bool accept, int userId, int friendId, String extraInfo) {
    UserFriendApi.addFriendResult(accept, userId, friendId, extraInfo,
        (result) {
      if (result.success) {
        showToast("发送请求成功");
        Navigator.pop(context);
      } else {
        showToast(result.message);
      }
    }, (code, msg) {
      showToast(msg);
    });
  }
}

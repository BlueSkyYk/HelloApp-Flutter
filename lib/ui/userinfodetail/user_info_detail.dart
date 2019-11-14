import 'package:flutter/material.dart';
import 'package:hello_app/data/api/user_friend_api.dart';
import 'package:hello_app/data/entity/search_user_entity.dart';
import 'package:hello_app/data/entity/user_entity.dart';
import 'package:hello_app/data/local_data_manager.dart';
import 'package:hello_app/util/view.dart';
import 'package:quiver/strings.dart';

enum DetailType {
  //显示当前用户信息
  DETAIL_TYPE_USER_SELF,
  //显示陌生人信息
  DETAIL_TYPE_STRANGER_USER,
  //显示好友信息
  DETAIL_TYPE_FRIEND_USER
}

class UserInfoDetailPage extends StatefulWidget {
  final DetailType detailType;
  final UserEntity user;
  final SearchUserEntity searchUser;

  UserInfoDetailPage(this.detailType,
      {Key key, @required this.user, @required this.searchUser})
      : super(key: key);

  @override
  _UserInfoDetailPageState createState() =>
      _UserInfoDetailPageState(detailType, user: user, searchUser: searchUser);
}

class _UserInfoDetailPageState extends State<UserInfoDetailPage> {
  DetailType _detailType = DetailType.DETAIL_TYPE_STRANGER_USER;
  UserEntity user;
  SearchUserEntity searchUser;

  bool _btnEnable = true;

  _UserInfoDetailPageState(this._detailType, {this.user, this.searchUser});

  @override
  Widget build(BuildContext context) {
    if (user == null && searchUser == null) {
      showToast("数据错误");
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 130,
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Row(
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/qq.png",
                      image:
                          "http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 34),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "懒烂蓝",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text("懒烂蓝"),
                      Text("懒烂蓝"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //横线
          Container(
            margin: EdgeInsets.only(left: 24, right: 24),
            color: Colors.black26,
            height: 1,
          ),
          Container(),
          //底部的按钮
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
                  width: double.infinity,
                  height: 44,
                  child: RaisedButton(
                    textColor: Colors.white,
                    onPressed: getButtonClickListener(_btnEnable),
                    child: Text(
                      "添加好友",
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //获取底部按钮点击监听
  VoidCallback getButtonClickListener(bool btnEnable) {
    if (_btnEnable) {
      return () {
        TextEditingController controller = TextEditingController();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("添加好友"),
              content: getInputDialogContent("验证信息", controller),
              actions: getDialogAction(context, () {
                var verMsg = controller.text;
                if (isEmpty(verMsg)) {
                  showToast("请输入验证信息");
                } else {
                  //发送添加好友请求
                  sendAddFriendRequest(searchUser.userId, verMsg);
                }
              }),
            );
          },
        );
      };
    } else {
      return null;
    }
  }

  //发送添加好友请求
  void sendAddFriendRequest(int friendId, String verMsg) {
    LocalDataManager.getUserFromLocal((user) {
      if (user != null) {
        UserFriendApi.addFriendRequest(user.userId, friendId, verMsg, (result) {
          if (result.success) {
            showToast("申请提交成功。等待好友通过申请");
            Navigator.pop(context);
          } else {
            showToast(result.message);
          }
        }, (code, msg) {
          showToast(msg);
        });
      } else {
        showToast("数据出错。");
      }
    });
  }
}

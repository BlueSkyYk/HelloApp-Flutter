import 'package:flutter/material.dart';
import 'package:hello_app/ui/add_friend_ver/add_friend_ver_page.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final TextStyle _itemTextStyle =
      const TextStyle(fontSize: 16, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x10000000),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 26),
            height: 160,
            child: Row(
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
                          style: TextStyle(fontSize: 20, color: Colors.black87),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "用户名:" + "Hello_FFJHGWE34",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 10),
            child: getMenuList(),
          ),
        ],
      ),
    );
  }

  //获取菜单列表
  Widget getMenuList() {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFriendVerPage()));
          },
          child: Container(
            color: Colors.white,
            height: 50,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.center_focus_strong),
                    Text(
                      "好友动态",
                      style: _itemTextStyle,
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.black87,
          margin: EdgeInsets.only(left: 14, right: 14),
        ),
        GestureDetector(
          child: Container(
            color: Colors.white,
            height: 50,
            padding: EdgeInsets.only(left: 14, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.center_focus_strong),
                    Text(
                      "好友动态",
                      style: _itemTextStyle,
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

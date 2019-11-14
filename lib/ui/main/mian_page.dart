import 'package:flutter/material.dart';
import 'package:flutter_im_plugin/flutter_im_plugin.dart';
import 'package:hello_app/im/im_manager.dart';
import 'package:hello_app/ui/addfriend/add_friend_page.dart';
import 'package:hello_app/ui/contacts/contacts_page.dart';
import 'package:hello_app/ui/find/find_page.dart';
import 'package:hello_app/ui/home/home_page.dart';
import 'package:hello_app/ui/person/person_page.dart';
import 'package:hello_app/util/notification_util.dart';
import 'package:hello_app/util/view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends NativeCallFlutterPluginState<MainPage> {
  static const List<String> _tabTitle = ["消息", "联系人", "发现", "我的"];
  static const List<IconData> _tabIconData = [
    Icons.message,
    Icons.contacts,
    Icons.find_in_page,
    Icons.person
  ];
  static List<Widget> _tabPage = [
    HomePage(),
    ContactsPage(),
    FindPage(),
    PersonPage()
  ];

  //当前Page索引
  int _currIndex = 0;

  //当前右边Icon
  Widget _rightActionWidget;

  @override
  void initState() {
    super.initState();
    //设置消息监听器
    setMessageCallback(IMManager.getInstance().createMsgListener());
    _rightActionWidget = Icon(Icons.add);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabTitle[_currIndex]),
        actions: <Widget>[
          IconButton(
              icon: _rightActionWidget,
              onPressed: () {
                switch (_currIndex) {
                  case 0: //消息
                  case 1: //联系人
                    //跳转到添加好友页面
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFriendPage()));
                    break;
                  case 2:
                    break;
                  case 3:
                    break;
                }
              }),
        ],
      ),
      body: _tabPage[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //超过三个不显示，设置为fixed
        items: _getBottomBarList(),
        currentIndex: _currIndex,
        onTap: (index) {
          setState(() {
            _currIndex = index;
            switch (_currIndex) {
              case 0:
              case 1:
                _rightActionWidget = Icon(Icons.add);
                break;
              case 2:
                _rightActionWidget = Container();
                break;
              case 3:
                _rightActionWidget = Container();
                break;
            }
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomBarList() {
    return List.generate(_tabTitle.length, (index) {
      return BottomNavigationBarItem(
          icon: Icon(
            _tabIconData[index],
          ),
          title: Text(_tabTitle[index]));
    });
  }
}

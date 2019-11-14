import 'package:flutter/material.dart';
import 'package:hello_app/ui/search/search_page.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("添加好友")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black12,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                //跳转到搜索页面
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(SearchType.TYEP_ADD_FRIEND)));
              },
              child: Container(
                color: Colors.white,
                height: 50,
                padding: EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "手机号/昵称/用户名",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

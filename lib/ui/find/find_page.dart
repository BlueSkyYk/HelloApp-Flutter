import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  List<String> _titleList = [
    "测试1",
    "测试2",
    "测试3",
    "测试4",
    "测试5",
    "测试6",
    "测试7",
    "测试8",
    "测试9",
    "测试10"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _titleList.length,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black38,
              isScrollable: true,
              tabs: _titleList.map((title) {
                return Center(
                  child: Text(title),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: _titleList.map((title) {
                return Center(
                  child: Text(title),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

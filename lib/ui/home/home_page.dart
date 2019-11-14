import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_app/util/view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _list = <int>[
    3,
    4,
    5,
    3,
    4,
    2,
    3,
    3,
    4,
    4,
    5,
    5,
    6,
    3,
    2,
    3,
    4,
    5,
    6,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: getClickSearchView(() {}),
            floating: false,
          ),
          SliverFixedExtentList(
            itemExtent: 70,
            delegate: SliverChildBuilderDelegate((context, index) {
              return getListItem(_list[index]);
            }, childCount: _list.length),
          )
        ],
      ),
    );
  }
}

Widget getListItem(dynamic x) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 16, right: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/qq.png",
            image:
                "http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg",
            width: 42,
            height: 42,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            height: 46,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Android开发交流群",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "12:32",
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "成独九分裤垃圾是的反馈静安寺的建安路附近发斯蒂芬",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: "33".length > 1
                              ? BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                )
                              : BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 2, bottom: 2),
                          child: Text("33",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//import 'package:flutter/material.dart';
//
//var _tabController = TabController(length: 3, vsync: ScrollableState());
//
//
//Widget build(BuildContext context) {
//  return Container(
//    color: Colors.white,
//    child: NestedScrollView(
//      body: TabBarView(
//        controller: _tabController,
//        children: _tabTitles.map((tabItem) {
//          return Builder(
//            builder: (context) {
//              return CustomScrollView(
//                slivers: <Widget>[
//                  SliverOverlapInjector(
//                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
//                        context),
//                  ),
////                    ListView(
////                      physics: NeverScrollableScrollPhysics(),
////                      shrinkWrap: true,
////                      children: <Widget>[
////                        Text("急急急"),
////                        Text("急急急"),
////                        Text("急急急"),
////                        Text("急急急"),
////                        Text("急急急"),
////                      ],
////                    )
//                ],
//              );
//            },
//          );
//        }).toList(),
//      ),
//      headerSliverBuilder: (context, innerBoxIsScrolled) {
//        return <Widget>[
//          //搜索栏
//          SliverAppBar(
//            title: getSearchView(null),
//            backgroundColor: Colors.white,
//          ),
//          SliverOverlapAbsorber(
//            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//            child: SliverAppBar(
//              backgroundColor: Colors.white,
//              pinned: true,
//              bottom: PreferredSize(
//                child: TabBar(
//                    indicator: BoxDecoration(
//                        shape: BoxShape.rectangle,
//                        color: Colors.red,
//                        borderRadius: BorderRadius.circular(20)),
//                    labelColor: Colors.white,
//                    unselectedLabelColor: Colors.black87,
//                    controller: _tabController,
//                    tabs: _tabTitles.map((tabItem) {
//                      return Tab(
//                        text: tabItem.tabTitle,
//                      );
//                    }).toList()),
//              ),
//            ),
//          ),
//
////            SliverToBoxAdapter(
////              child: TabBarView(controller: _tabController, children: <Widget>[
////                SliverFixedExtentList(
////                  itemExtent: 40,
////                  delegate: SliverChildBuilderDelegate((context, index) {
////                    return ListTile(
////                      title: Text("张三" + index.toString()),
////                      leading: Icon(Icons.person),
////                    );
////                  }, childCount: 80),
////                ),
////                SliverFixedExtentList(
////                  itemExtent: 40,
////                  delegate: SliverChildBuilderDelegate((context, index) {
////                    return ListTile(
////                      title: Text("张三" + index.toString()),
////                      leading: Icon(Icons.person),
////                    );
////                  }, childCount: 80),
////                ),
////                SliverFixedExtentList(
////                  itemExtent: 40,
////                  delegate: SliverChildBuilderDelegate((context, index) {
////                    return ListTile(
////                      title: Text("张三" + index.toString()),
////                      leading: Icon(Icons.person),
////                    );
////                  }, childCount: 80),
////                ),
////              ]),
////            ),
////            SliverFillRemaining(
////                child: TabBarView(
////              controller: _tabController,
////              children: <Widget>[
////                SliverToBoxAdapter(
////                  child: getAddbookList(_addbookList),
////                ),
////                Text("xxxx"),
////                Text("xxxx"),
////              ],
////            )),
////            SliverFixedExtentList(
////              itemExtent: 50,
////              delegate: SliverChildBuilderDelegate((context, index) {
////                return ListTile(
////                  title: Text("张三" + index.toString()),
////                  leading: Icon(Icons.person),
////                );
////              }, childCount: 50),
////            ),
//        ];
//      },
//    ),
//  );
//}



//SliverToBoxAdapter getFriendExtentList(List<FriendGroupModel> list) {
//  return SliverToBoxAdapter(
//    child: ExpansionPanelList(
//      expansionCallback: (index, isExpanded) {
//        setState(() {
//          list[index].isExpanded = !isExpanded;
//        });
//      },
//      children: list.map<ExpansionPanel>((group) {
//        return ExpansionPanel(
//          isExpanded: group.isExpanded,
//          headerBuilder: (context, isExpanded) {
//            return Row(
//              children: <Widget>[
//                Text("xxx"),
//                Text(group.groupName),
//                Expanded(
//                  child: Text(
//                    group.onlineCount.toString() +
//                        "/" +
//                        group.totalCount.toString(),
//                    textAlign: TextAlign.right,
//                  ),
//                ),
//              ],
//            );
//          },
//          body: ListView.builder(
//            itemBuilder: (context, index) {
//              var friend = group.friendList[index];
//              return ListTile(
//                title: Text(friend.name),
//                leading: Icon(Icons.person),
//              );
//            },
//            itemCount: group.friendList.length,
//            shrinkWrap: true,
//            physics: NeverScrollableScrollPhysics(),
//          ),
//        );
//      }).toList(),
//    ),
//  );
//}


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_app/util/view.dart';
import 'package:hello_app/view/my_expansion_tile.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

const Duration _kExpand = Duration(milliseconds: 200);

class _ContactsPageState extends State<ContactsPage> {
  //Tab列表
  static List<TabItem> _tabTitles = [
    TabItem(1, "好友"),
    TabItem(2, "群聊"),
    TabItem(3, "通讯录")
  ];

  //好友列表
  List<FriendGroupModel> _friendList = [];

  //群聊列表
  List<dynamic> _groupList = [];

  //通讯录
  List<dynamic> _addbookList = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      FriendGroupModel friendGroupModel = new FriendGroupModel();
      _friendList.add(friendGroupModel);
      friendGroupModel.groupId = (i + 1);
      friendGroupModel.groupName = "分组-" + (i + 1).toString();
      friendGroupModel.totalCount = 100;
      friendGroupModel.onlineCount = 23;
      friendGroupModel.isExpanded = false;
      friendGroupModel.friendList = [];
      for (int j = 0; j < 40; j++) {
        FriendModel friendModel = new FriendModel();
        friendGroupModel.friendList.add(friendModel);
        friendModel.userId = (i * 10) + j + 1;
        friendModel.name = "张三";
        friendModel.status = (j % 2) + 1;
        friendModel.statusMsg = friendModel.status == 1 ? "iphone在线" : "离线并留言";
        friendModel.descInfo = "如果想增加切片的容量，我们必须创建一个新的更大的切片并把原分片的内容都拷贝过来。";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: _tabTitles.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                //搜索框
                title: getClickSearchView(null),
              ),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(14)),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black87,
                      tabs: _tabTitles.map((tabItem) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(14, 3, 14, 3),
                          child: Text(
                            tabItem.tabTitle,
                          ),
                        );
                      }).toList()),
                ),
              )
            ];
          },
          body: TabBarView(
              children: _tabTitles.map((tableItem) {
            return Builder(
              builder: (context) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    tableItem.tabId == 1
                        //好友列表
                        ? getFriendList(_friendList)
                        : (tableItem.tabId == 2
                            //群列表
                            ? getGroupExtentList(_groupList)
                            //通讯录
                            : getAddbookList(_addbookList)),
                  ],
                );
              },
            );
          }).toList()),
        ),
      ),
    );
  }

  //获取好友列表View
  SliverToBoxAdapter getFriendList(List<FriendGroupModel> list) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MyExpansionTile(
              onExpansionChanged: (index) {},
              title: Container(
                child: Row(
                  children: <Widget>[
                    Text(
                      list[index].groupName,
                      style: TextStyle(fontSize: 15),
                    ),
                    Expanded(
                      child: Text(
                        list[index].onlineCount.toString() +
                            "/" +
                            list[index].totalCount.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 10, color: Colors.black45),
                      ),
                    ),
                  ],
                ),
              ),
              children: list[index].friendList.map((friend) {
                return ListTile(
                  title: Text(friend.name),
                  leading: Icon(Icons.person),
                );
              }).toList(),
            );
          },
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
        ),
      ),
    );
  }

  //获取群聊列表View
  SliverFixedExtentList getGroupExtentList(List<dynamic> list) {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate((_, index) {
        return ListTile(
          title: Text("张三" + index.toString()),
          leading: Icon(Icons.person),
        );
      }, childCount: list.length),
      itemExtent: 50,
    );
  }

  //获取联系人列表View
  SliverToBoxAdapter getAddbookList(List<dynamic> list) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text("联系人"),
          );
        },
        itemExtent: 30,
        itemCount: 2,
      ),
    );
  }
}

//Tab Model
class TabItem {
  const TabItem(this.tabId, this.tabTitle);

  final int tabId;
  final String tabTitle;
}

//好友分组Model
class FriendGroupModel {
  int groupId; //分组Id
  String groupName; //分组名称
  int totalCount; //总人数
  int onlineCount; //在线人数
  List<FriendModel> friendList; //好友列表
  bool isExpanded; //是否展开
}

//好友Model
class FriendModel {
  int userId; // 用户Id
  String name; // 用户昵称
  int status; // 1、在线，2离线
  String statusMsg; // 状态信息
  String descInfo; // 描述信息，最新动态或个性签名
}

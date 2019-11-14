import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_app/data/api/user_api.dart';
import 'package:hello_app/data/entity/search_user_entity.dart';
import 'package:hello_app/ui/userinfodetail/user_info_detail.dart';
import 'package:hello_app/util/view.dart';
import 'package:quiver/strings.dart';

enum SearchType {
  //添加好友
  TYEP_ADD_FRIEND,
}

class SearchPage extends StatefulWidget {
  final SearchType searchType;

  SearchPage(@required this.searchType, {Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(searchType);
}

class _SearchPageState extends State<SearchPage> {
  final SearchType _searchType;

  TextEditingController _searchInputController;
  List<SearchUserEntity> _searchUserList = [];

  _SearchPageState(@required this._searchType);

  @override
  void initState() {
    super.initState();
    _searchInputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black87,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 40,
                          ),
                          child: TextField(
                            controller: _searchInputController,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                filled: true,
                                fillColor: Colors.white,
                                counterStyle: TextStyle(color: Colors.white),
                                hintText: "手机号/昵称/用户名",
                                hintStyle: TextStyle(color: Colors.black54),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10)),
                            autofocus: true,
                            textInputAction: TextInputAction.search,
                            onChanged: (text) {
                              if (text.length > 15) {
                                _searchInputController.text =
                                    text.substring(0, 15);
                              }
                              _searchInputController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: 15));
                            },
                            onSubmitted: _doSearch,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 40,
                          child: Text(
                            "取消",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _getSearchUserListItem(_searchUserList[index]);
              },
              itemCount: _searchUserList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchUserListItem(SearchUserEntity searchUser) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserInfoDetailPage(
                    DetailType.DETAIL_TYPE_STRANGER_USER,
                    searchUser: searchUser)));
      },
      child: Container(
        color: Colors.white,
        height: 60,
        padding: EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 50,
              child: ClipOval(
                child: Image.network(
                    "http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Text(
                      "${searchUser.nickname}(${searchUser.username})",
                      style: TextStyle(fontSize: 16),
                    ),
                    padding: EdgeInsets.only(top: 6),
                  ),
                  Padding(
                    child:
                        Text("${searchUser.nickname}(${searchUser.username})"),
                    padding: EdgeInsets.only(top: 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //搜索
  void _doSearch(String keyword) {
    if (isEmpty(keyword)) {
      showToast("请输入关键字");
      return;
    }
    //查找用户
    UserApi.searchUser(keyword, (result) {
      if (result.success) {
        if (result.data != null && !result.data.isEmpty) {
          setState(() {
            _searchUserList.clear();
            _searchUserList.addAll(result.data);
          });
        } else {
          showToast("未查询到用户信息");
        }
      } else {
        showToast(result.message);
      }
    }, (errCode, errMsg) {
      showToast(errMsg);
    });
  }
}

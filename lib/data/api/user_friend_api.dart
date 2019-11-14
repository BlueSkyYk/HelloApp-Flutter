import 'package:hello_app/data/http_constants.dart';
import 'package:hello_app/data/res/result.dart';
import 'package:hello_app/util/http_util.dart';

class UserFriendApi {
  UserFriendApi._();

  //添加好友请求
  static void addFriendRequest(int userId, int friendId, String extraInfo,
      HttpSuccess<Result> success, HttpFail fail) {
    var param = {
      "userId": userId,
      "friendId": friendId,
      "extraInfo": extraInfo,
    };
    HttpUtil.getInstance().post(UserFriendURL.ADD_FRIEND_REQUEST, (resultMap) {
      var result = Result.parseResultByMapData(resultMap);
      success(result);
    }, fail, param: param);
  }

  //添加好友结果
  static void addFriendResult(bool accept, int userId, int friendId,
      String extraInfo, HttpSuccess<Result> success, HttpFail fail) {
    var param = {
      "userId": userId,
      "friendId": friendId,
      "extraInfo": extraInfo,
    };
    HttpUtil.getInstance().post(UserFriendURL.ADD_FRIEND_RESULT, (resultMap) {
      var result = Result.parseResultByMapData(resultMap);
      success(result);
    }, fail, param: param);
  }
}

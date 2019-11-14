import 'package:hello_app/data/entity/search_user_entity.dart';
import 'package:hello_app/data/entity/user_entity.dart';
import 'package:hello_app/data/http_constants.dart';
import 'package:hello_app/data/res/result.dart';
import 'package:hello_app/util/http_util.dart';

class UserApi {
  UserApi._();

  //登录
  static void login(
      int loginType,
      String phone,
      String smsCode,
      String password,
      String qqAuthCode,
      HttpSuccess<Result<UserEntity>> success,
      HttpFail fail) {
    var param = {
      "loginType": loginType,
      "password": password,
      "phone": phone,
      "qqAuthCode": qqAuthCode,
      "smsCode": smsCode
    };
    HttpUtil.getInstance().post(UserURL.LOGIN, (resultMap) {
      var result = Result.parseResultByMapData(resultMap);
      if (result.success) {
        if (result.data != null) {
          Result<UserEntity> userResult = Result.create(result);
          userResult.data = UserEntity.fromJson(result.data);
          success(userResult);
        } else {
          fail(ResultCode.FAIL, "登录失败");
        }
      } else {
        fail(result.code, result.message);
      }
    }, fail, param: param);
  }

  //搜索用户
  static void searchUser(String keyword,
      HttpSuccess<Result<List<SearchUserEntity>>> success, HttpFail fail) {
    var param = {"keyword": keyword};
    HttpUtil.getInstance().post(UserURL.SEARCH_USER, (resultMap) {
      var result = Result.parseResultByMapData(resultMap);
      if (result.success) {
        if (result == null) {
          fail(ResultCode.FAIL, "查找用户失败");
          result;
        }
        Result<List<SearchUserEntity>> usersResult = Result.create(result);
        List list = result.data;
        if (list.isEmpty) {
          fail(ResultCode.FAIL, "未查找到相关用户");
        } else {
          usersResult.data = List<SearchUserEntity>.generate(
              list.length, (index) => SearchUserEntity.fromJson(list[index]));
          success(usersResult);
        }
      } else {
        fail(result.code, result.message);
      }
    }, fail, param: param);
  }
}

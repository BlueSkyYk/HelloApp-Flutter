//验证码相关
import 'package:hello_app/constants/constants.dart';

//短信相关
class SmsURL {
  //获取短信验证码
  static const String GET_SMS_CODE =
      Constants.BASE_URL + "/v1/sms/getSmsVerCode";
}

//用户相关
class UserURL {
  //用户登录
  static const String LOGIN = Constants.BASE_URL + "/v1/user/login";

  //搜索用户
  static const String SEARCH_USER = Constants.BASE_URL + "/v1/user/searchUser";
}

//用户好友相关
class UserFriendURL {
  //添加好友请求
  static const String ADD_FRIEND_REQUEST =
      Constants.BASE_URL + "/v1/userFriend/addFriendRequest";

  //添加好友响应结果（好友同意或拒绝）
  static const String ADD_FRIEND_RESULT =
      Constants.BASE_URL + "/v1/userFriend/addFriendResult";
}

import 'package:hello_app/data/http_constants.dart';
import 'package:hello_app/data/res/result.dart';
import 'package:hello_app/util/http_util.dart';

class SmsApi {
  SmsApi._();

  /**
   * 获取短信验证码
   */
  static void getSmsCode(
      String phone, HttpSuccess<Result> success, HttpFail fail) {
    //创建参数
    var param = {"phone": phone};
    //发送请求
    HttpUtil.getInstance().post(SmsURL.GET_SMS_CODE, (resultMap) {
      Result result = Result.parseResultByMapData(resultMap);
      success(result);
    }, fail, param: param);
  }
}

class StringUtil {
  StringUtil._() {}

  /**
   * 检查手机号
   */
  static bool checkPhone(String phone) {
    RegExp exp =
        RegExp(r'^1([38][0-9]|14[579]|5[^4]|16[6]|7[1-35-8]|9[189])\d{8}$');
    return exp.hasMatch(phone);
  }
}

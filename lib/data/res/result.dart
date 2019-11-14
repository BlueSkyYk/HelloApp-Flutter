class Result<T> {
  int code;
  bool success;
  String message;
  T data;

  Result({this.code, this.data, this.success, this.message});

  Result.create(Result result) {
    this.code = result.code;
    this.success = result.success;
    this.message = result.message;
  }

  //解析Result
  Result.parseResultByMapData(Map map) {
    this.code = map["code"];
    this.success = map["success"];
    this.message = map["message"];
    this.data = map["data"];
  }
}

class ResultCode {
  static const int SUCCESS = 200;
  static const int FAIL = 1000;
}

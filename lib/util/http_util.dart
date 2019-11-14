import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';

class HttpUtil {
  //单例写法

  static HttpUtil _instance;

  static HttpUtil getInstance() {
    if (_instance == null) {
      _instance = HttpUtil._();
    }
    return _instance;
  }

  static HttpUtil get instance => getInstance();

  Dio _dio;

  HttpUtil._() {
    _init();
  }

  //初始化
  void _init() {
    _dio = new Dio();
    //设置连接超时时长 5s
    _dio.options.connectTimeout = 5000;
    //响应超时时长 3s
    _dio.options.receiveTimeout = 3000;
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request) {
      print("请求：" +
          request.path +
          "\n" +
          "queryMap：" +
          jsonEncode(request.queryParameters));
    }, onResponse: (response) {
      print("响应：" +
          response.request.path +
          "\n" +
          "queryMap：" +
          jsonEncode(response.data));
    }));
  }

  // Get请求
  void get<T>(String url, HttpSuccess<Map> success, HttpFail fail,
      {Map<String, dynamic> queryMap}) async {
    Response response = await _dio.get(url, queryParameters: queryMap);
    if (response.statusCode == 200) {
      if (response.data != null) {
        success(response.data);
      } else {
        fail(-100, "数据错误");
      }
    } else {
      fail(response.statusCode, "网络开小差啦!");
    }
  }

  // Post请求
  void post(String url, HttpSuccess<Map> success, HttpFail fail,
      {Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.post(url, data: param);
      if (response.statusCode == 200) {
        if (response.data != null) {
          success(response.data);
        } else {
          fail(-100, "数据错误");
        }
      } else {
        fail(-100, "网络开小差啦!");
      }
    } catch (e) {
      fail(-100, "网络开小差啦!");
    }
  }
}

typedef HttpSuccess<T> = Function(T result);

typedef HttpFail = Function(int errCode, String errMsg);

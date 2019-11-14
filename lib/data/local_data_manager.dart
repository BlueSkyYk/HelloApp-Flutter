import 'dart:convert';
import 'package:hello_app/data/entity/user_entity.dart';
import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataManager {
  LocalDataManager._() {}

  //从本地获取User信息
  static UserEntity getUserFromLocal(DataCallback<UserEntity> callback) {
    getSharedPreferences().then((instance) {
      var str = instance.getString("user");
      if (isEmpty(str)) {
        callback(null);
      } else {
        try {
          UserEntity user = UserEntity.fromJson(json.decode(str));
          callback(user);
        } catch (e) {
          callback(null);
        }
      }
    });
  }

  //保存用户信息到本地
  static void saveUserToLocal(UserEntity user) {
    getSharedPreferences().then((instance) {
      instance.setString("user", json.encode(user));
    });
  }
}

typedef DataCallback<T> = Function(T result);
/**
 * 获取SharedPreferences
 */
Future<SharedPreferences> getSharedPreferences() =>
    SharedPreferences.getInstance();

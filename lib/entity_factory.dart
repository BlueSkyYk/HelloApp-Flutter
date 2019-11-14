import 'package:hello_app/data/entity/search_user_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SearchUserEntity") {
      return SearchUserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
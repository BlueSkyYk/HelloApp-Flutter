import 'package:hello_app/util/notification_util.dart';
import 'package:hello_app/util/view.dart';

class IMManager {
  static IMManager _instance;

  static IMManager getInstance() {
    if (_instance == null) {
      _instance = IMManager._();
    }
    return _instance;
  }

  static get instance => getInstance();

  IMManager._();

  //消息监听器
  Function(Map<String, Object>) _msgListener = (msgMap) {
    print("IMManager--------Flutter收到消息：" + msgMap.toString());
    //解析消息
    var msgModel = MessageModel.fromJson(msgMap);
    switch (msgModel.type) {
      case MessageModel.TYPE_SYSTEM: //系统消息

        break;
      case MessageModel.TYPE_ADD_FRIEND_REQ: //添加好友请求
        NotificationUtil.showNotification(2, "消息", "发送一个通知。。。", (notification) {},
            payloadCallback: (payload) {
              showToast("点击了通知栏：" + payload);
            });
        break;
      case MessageModel.TYPE_ADD_FRIEND_RES: //添加好友结果

        break;
    }
  };

  //获取消息回调器
  Function(Map<String, Object>) createMsgListener() {
    return _msgListener;
  }
}

//消息Model
class MessageModel {
  //系统消息
  static const int TYPE_SYSTEM = 0;

  //添加好友请求
  static const int TYPE_ADD_FRIEND_REQ = 1;

  //添加好友结果返回
  static const int TYPE_ADD_FRIEND_RES = 1;

  int msgId;
  int type;
  int fromUserId;
  String fromNickname;
  String content;

  MessageModel.fromJson(Map<String, dynamic> json) {
    msgId = json['msgId'];
    type = json['type'];

    fromUserId = json['fromUserId'];
    fromUserId = json['fromUserId'];
    content = json['content'];
  }
}

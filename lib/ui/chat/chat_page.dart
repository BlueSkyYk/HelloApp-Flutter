import 'package:flutter/material.dart';
import 'package:hello_app/db/entity/entity_message.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  //消息实体
  List<MessageEntity>_messageList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("懒烂蓝"),),
      body: ListView.builder(itemBuilder: (context, index) {

      }, itemCount: _messageList.length,),
    );
  }


}

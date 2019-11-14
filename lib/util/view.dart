import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
  );
}

/**
 * 获取点击搜索View
 */
Widget getClickSearchView(GestureTapCallback topCallback) {
  return GestureDetector(
    child: Container(
      height: 36,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
          color: Color(0x10000000),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black38,
            size: 18,
          ),
          Text(
            "搜索",
            style: TextStyle(color: Colors.black38, fontSize: 15),
          )
        ],
      ),
    ),
    onTap: topCallback,
  );
}

/**
 * 获取输入对话框
 */
//Widget getInputDialog(BuildContext context, String title, String inputTitle,
//    DialogInputCallback inputCallback,
//    {DialogCancelCallback cancelCallback}) {
//  TextEditingController controller = TextEditingController();
//  return Material(
//      type: MaterialType.transparency,
//      child: Center(
//        child: Container(
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(10), color: Colors.white),
//          width: 260,
//          height: 180,
//          child: Container(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                SizedBox(
//                  height: 46,
//                  child: Center(
//                    child: Text(
//                      title,
//                      style: TextStyle(fontSize: 19),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        inputTitle,
//                        style: TextStyle(fontSize: 16, color: Colors.black54),
//                      ),
//                      Expanded(
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 4),
//                          child: TextField(
//                            style:
//                                TextStyle(fontSize: 16, color: Colors.black87),
//                            controller: controller,
//                            maxLines: 1,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.only(top: 20),
//                  height: 1,
//                  color: Colors.black26,
//                ),
//                Expanded(
//                  child: Row(
//                    children: <Widget>[
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            Navigator.pop(context);
//                            if (cancelCallback != null) {
//                              cancelCallback();
//                            }
//                          },
//                          child: Container(
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(10)),
//                                color: Colors.white),
//                            alignment: Alignment.center,
//                            child: Text(
//                              "取消",
//                            ),
//                          ),
//                        ),
//                      ),
//                      Container(
//                        width: 1,
//                        color: Colors.black26,
//                      ),
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            inputCallback(controller.text);
//                          },
//                          child: Container(
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.only(
//                                    bottomRight: Radius.circular(10)),
//                                color: Colors.white),
//                            alignment: Alignment.center,
//                            child: Text(
//                              "确定",
//                            ),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ));
//}

/**
 * 获取输入对话框内容
 */
Widget getInputDialogContent(
    String inputTitle, TextEditingController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        inputTitle,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 4),
          child: TextField(
            style: TextStyle(fontSize: 16, color: Colors.black87),
            controller: controller,
            maxLines: 1,
          ),
        ),
      ),
    ],
  );
}

/**
 * 获取对话框Action
 */
List<Widget> getDialogAction(
    BuildContext dialogContext, DialogConfirmCallback confirmCallback,
    {DialogCancelCallback cancelCallback}) {
  return <Widget>[
    GestureDetector(
      onTap: () {
        Navigator.pop(dialogContext);
        cancelCallback != null ? cancelCallback() : null;
      },
      child: SizedBox(
        width: 50,
        height: 30,
        child: Text("取消"),
      ),
    ),
    GestureDetector(
      onTap: () {
        confirmCallback();
      },
      child: SizedBox(
        width: 50,
        height: 30,
        child: Text("确定"),
      ),
    ),
  ];
}

typedef DialogConfirmCallback = Function();
typedef DialogCancelCallback = Function();

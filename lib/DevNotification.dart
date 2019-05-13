import 'package:flutter/material.dart';

class DevNotificationTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("通知Notification"),
        ),
        body: ContentPage());
  }
}

class ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NotificationListener(
      //监听通知
      onNotification: (notification) {
        setState(() {
          _msg += notification.msg + "  ";
        });
        //print(notification);
        switch (notification.runtimeType) {
          case ScrollStartNotification:
            print("开始滚动");
            break;
          case ScrollUpdateNotification:
            print("正在滚动");
            break;
          case ScrollEndNotification:
            print("滚动停止");
            break;
          case OverscrollNotification:
            print("滚动到边界");
            break;
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
//            RaisedButton(
//              onPressed: () => MyNotification("Hi").dispatch(context),
//              child: Text("Send Notification"),
//            ),

            Builder(
              builder: (context) {
                return RaisedButton(//按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}

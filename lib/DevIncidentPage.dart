import 'package:flutter/material.dart';
import 'EventBus.dart';

class DevIncidentTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    // TODO: implement build
    return Theme(
        data: ThemeData(
            primaryColor: Colors.cyan,
            iconTheme: IconThemeData(color: Colors.deepOrange)),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "事件处理与通知",
                textScaleFactor: 2,
              ),
            ),
            body: ContentPage()));
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
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  double _top = 0.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //页面A中-监听登录事件
    bus.on("login", (arg) {
      // do something
    });

    //登录页B中-登录成功后触发登录事件，页面A中订阅者会被调用
    bus.emit("login", null);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );

    Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(300.0, 200.0)),
                child:
                    DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
              ),
              onPointerDown: (event) => print("down0"),
            ),
            Listener(
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                child: Center(child: Text("左上角200*100范围内非文本区域点击")),
              ),
              onPointerDown: (event) => print("down1"),
              behavior: HitTestBehavior.translucent, //放开此行注释后可以"点透"
            )
          ],
        ),
        Listener(
          child: Container(
            alignment: Alignment.center,
            color: Colors.blue,
            width: 300.0,
            height: 150.0,
            child: Text(_event?.toString() ?? "",
                style: TextStyle(color: Colors.white)),
          ),
          onPointerDown: (PointerDownEvent event) =>
              setState(() => _event = event),
          onPointerMove: (PointerMoveEvent event) =>
              setState(() => _event = event),
          onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
        ),
        Listener(
          child: IgnorePointer(
            child: Listener(
              child: Container(
                color: Colors.red,
                width: 200.0,
                height: 100.0,
              ),
              onPointerDown: (event) => print("in"),
            ),
          ),
          onPointerDown: (event) => print("up"),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DevListeningScrollTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ContentPage();
  }
}

class ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentpageState();
  }
}

class ContentpageState extends State<ContentPage> {
  ScrollController _controller = ScrollController();
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  String _progress = "0%"; //保存进度百分比

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      print(_controller.offset); ////打印滚动位置
      setState(() {
        if (_controller.offset < 1000 && showToTopBtn) {
          showToTopBtn = false;
        } else if (_controller.offset >= 1000 && showToTopBtn == false) {
          showToTopBtn = true;
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动监听及控制ScrollController"),
      ),
      body: Scrollbar(
        // 监听滚动通知
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            //重新构建
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            //return true; //放开此行注释后，进度条将失效
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(
                      "item ${index + 1}",
                      textScaleFactor: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                    alignment: Alignment.center,
                    color: Colors.cyan[(index % 9 + 1) * 100],
                  );
                },
                itemCount: 100,
                itemExtent: 50, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
              ),
              CircleAvatar(
                //显示进度百分比
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(seconds: 2), curve: Curves.ease);
              }),
    );
  }
}

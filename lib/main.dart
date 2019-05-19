import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:english_words/english_words.dart';
import 'MyPage.dart';
import 'BasicsLib.dart';
import 'iOSBasicsLib.dart';
import 'ImagesPage.dart';
import 'buttonWidget.dart';
import 'DevTextField.dart';
import 'DevForm.dart';
import 'DevExpanded.dart';
import 'DevStackLayout.dart';
import 'DevAppBar.dart';
import 'DevConstrainedBox.dart';
import 'DevDecoratedBox.dart';
import 'DevExamplePage.dart';
import 'DevListView.dart';
import 'DevGridView.dart';
import 'DevPartyGrideView.dart';
import 'DevCustomScrollView.dart';
import 'DevListenScrollView.dart';
import 'DevIncidentPage.dart';
import 'DevNotification.dart';
import 'DevAnimation.dart';
import 'DevPushRoute.dart';
import 'DevCustomWidget.dart';
import 'DevTurnBox.dart';
import 'DevRenjuPage.dart';
import 'DevGetFilePathPage.dart';
import 'DevHttpClient.dart';
import 'DevDioClient.dart';
import 'DevWebSockets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        //注册路由表
        routes: {
          "new_page": (context) => NewRoute(),
          "tip_widgets": (context) => EchoRoute("内容固定")
        },
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('测试'),
          ),
          body: Builder(
              builder: (context) =>
                  ListView(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("webSocket"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DevWebSocketsTestRoute()
                          ));
                        },
                      ),
                      RaisedButton(
                        child: Text("获取沙盒文件夹"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DevGetFileTestRoute();
                              }));
                        },
                      ),
                      RaisedButton(
                        child: Text("网络请求"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DevHttpClientTestRoute();
                              }));
                        },
                      ),
                      RaisedButton(
                        child: Text("第三方网络库 Dio http库"),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DevDioClientTestRoute();
                              }));
                        },
                      ),
                      RaisedButton(
                        child: Text("推上去页面"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewRoute(),
                                  fullscreenDialog: true))
                              .then((d) {
                            print(d); //回调
                            debugDumpRenderTree();
                          }).catchError((e) {
                            print(e);
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text("翻页"),
                        onPressed: () {
                          Navigator.pushNamed(context, "tip_widgets");
                        },
                      ),
                      RandomWordsWidget(),
                      RaisedButton(
                        child: Text("状态管理page"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TapboxA()));
                        },
                      ),
                      RaisedButton(
                        child: Text("基础库的使用/按钮"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BaseWidget()));
                        },
                      ),
                      RaisedButton(
                        child: Text("iOS风格库"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => iOSBaseVC()));
                        },
                      ),
                      RaisedButton(
                        child: Text("图片加载/单复选框"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagesPage()));
                        },
                      ),
                      RaisedButton(
                        child: Text("各种自定义按钮"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => buttonWidget()));
                        },
                      ),
                      RaisedButton(
                        child: Text("输入框textfield"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TextFieldWidget()));
                        },
                      ),
                      RaisedButton(
                        child: Text("表单form"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormWidget()));
                        },
                      ),
                      RaisedButton(
                        child: Text("弹性布局Expanded"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FlexLayoutTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("层叠布局Stack"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StackLayoutTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("appBar Dev"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppBarLayoutTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("布局限制类容器ConstrainedBox和SizedBox"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ConstrainedBoxTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("装饰容器DecoratedBox"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DecoratedBoxTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("Scaffold、TabBar、底部导航 例子"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DevExampleTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("ListView"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevListViewTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("GridView"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevGridViewTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("第三方GridView"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevPartyGridViewTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("CustomScrollView"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevCustomScrollViewTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("滚动监听及控制ScrollController"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevListeningScrollTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("事件处理与通知"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevIncidentTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("通知Notification"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevNotificationTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("动画"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      DevAnimationTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("自定义路由跳转"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DevPushTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("自定义控件"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevCustomWidgetTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("TurnBox控件,旋转控件"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DevTurnBoxTestRoute()));
                        },
                      ),
                      RaisedButton(
                        child: Text("五子棋"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DevRenjuPageTestRoute()));
                        },
                      ),
                    ],
                  )),
        ));
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("page1")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('2222222222222'),
          IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              Navigator.pop(context, '哈哈哈');
            },
          )
        ],
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  EchoRoute(this.tip);

  final String tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo route"),
      ),
      body: Center(
        //回显tip内容
        child: Text(tip),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

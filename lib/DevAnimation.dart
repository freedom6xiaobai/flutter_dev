import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class DevAnimationTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("动画Page"),
      ),
      body: ContentPage(),
    );
  }
}

class ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentPageState();
  }
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.bounceIn); //使用弹性曲线
    animation = Tween(begin: 0.0, end: 100.0).animate(controller)
      ..addListener(() {//两种监听
        setState(() {});
      }); //图片宽高从0变到100

    animation.addStatusListener((status) {//状态监听
      if (status == AnimationStatus.completed) {//动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {//动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });
    controller.forward(); //启动动画(正向执行)
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose(); //路由销毁时需要释放动画资源
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TestAnimationView1(
      child: Image.asset("Images/3.jpg"),
      animation: animation,
    );

    Container(
      alignment: Alignment.center,
      width: animation.value,
      height: animation.value,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}

class TestAnimationView extends AnimatedWidget {
  TestAnimationView({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    // TODO: implement build
    return Center(
      child: Container(
        color: Colors.yellow,
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}

//自定义动画缩放控件
class TestAnimationView1 extends StatelessWidget {
  // ignore: missing_required_param
  TestAnimationView1({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}

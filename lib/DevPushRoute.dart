import 'package:flutter/material.dart';

class DevPushTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义路由跳转"),
      ),
      body: Builder(
        builder: (context) => Column(
              children: <Widget>[
                RaisedButton(
                    child: Text("跳转1"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              //动画时间为500毫秒
                              pageBuilder: (BuildContext context,
                                  Animation animation,
                                  Animation secondaryAnimation) {
                                return FadeTransition(
                                    //使用渐隐渐入过渡,
                                    opacity: animation,
                                    child: TestPageA() //路由B
                                    );
                              }));
                    }),
                RaisedButton(
                  child: Text("跳转2"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                            builder: (context) {
                              return TestPageA();
                            },
                            isActive: true));
                  },
                ),
                InkWell(
                  child: Hero(
                    tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
                    child: ClipOval(
                      child: Image.asset(
                        "Images/5.jpg",
                        width: 50.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    //打开B路由
                    Navigator.push(context, PageRouteBuilder(pageBuilder:
                        (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                      return new FadeTransition(
                          opacity: animation, child: HeroAnimationRouteB());
                    }));
                  },
                ),
                RaisedButton(
                  child: Text("跳转3"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        FadeRoute(
                            builder: (context) {
                              return StaggerDemo();
                            },
                            isActive: true));
                  },
                ),
              ],
            ),
      ),
    );
  }
}

class TestPageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("PageA"),
      ),
      body: Center(
        child: Text("PageA"),
      ),
    );
  }
}

//自定义pageroute 跳转
class FadeRoute extends PageRoute {
  FadeRoute(
      {@required this.builder,
      this.transitionDuration = const Duration(milliseconds: 300),
      this.opaque = true,
      this.barrierDismissible = false,
      this.barrierColor,
      this.barrierLabel,
      this.maintainState = true,
      this.isActive = true});

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  final bool isActive;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    //当前路由被激活，是打开新路由
    if (isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder(context),
      );
    } else {
      //是返回，则不应用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}

//路由B:
class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("原图"),
      ),
      body: Center(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: Image.asset("Images/6.jpg"),
        ),
      ),
    );
  }
}

//下面我们看一个例子，实现一个柱状图增长的动画：
//
//开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
//高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, //间隔，前60%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: .0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

//列子
class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      //先正向执行动画
      await _controller.forward().orCancel;
      //再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("柱形图动画"),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交错动画Widget
            child: StaggerAnimation(controller: _controller),
          ),
        ),
      ),
    );
  }
}

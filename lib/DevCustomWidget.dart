import 'package:flutter/material.dart';

class DevCustomWidgetTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("自定义控件"),
        ),
        body: Column(
          children: <Widget>[
            GradientButton(
              colors: [Colors.orange, Colors.red],
              height: 50.0,
              child: Text("Submit"),
              onTap: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightGreen, Colors.green[700]],
              child: Text("Submit"),
              onTap: onTap,
            ),
            GradientButton(
              height: 50.0,
              colors: [Colors.lightBlue[300], Colors.blueAccent],
              child: Text("Submit"),
              onTap: onTap,
            ),
            new Center(
              child: new Material(
                child: new InkWell(
                  onTap: () {
                    print(
                        '###########################点击了##################################');
                  },
                  child: new Container(
                    //不要在这里设置背景色，for则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                    width: 300.0,
                    height: 100.0,
                    margin: EdgeInsets.all(0.0),
                  ),
                ),
                color: Colors.yellow,
              ),
            ),
            new Center(
              child: new Material(
                child: new Ink(
                  //INK可以实现装饰容器，实现矩形  设置背景色
                  color: Colors.black,
                  child: new InkWell(
                    onTap: () {
                      print(
                          "@@@@@@@@@@@@@@@@@@@@@@@@@@@点击了@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
                    },
                    child: new Container(
                      width: 300.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ),
            new Center(
              child: new Material(
                child: new Ink(
                  //用ink圆角矩形
//                color: Colors.red,
                  decoration: new BoxDecoration(
                    /**
                     * assert(color == null || decoration == null,'Cannot provide both a color and
                     * a decoration\n'The color argument is just a shorthand
                     * for "decoration: new BoxDecoration(color: color)".')
                     * 在dart中使用assert 语句来中断正常的执行流程。
                     * “不能同时”使用Ink的变量color属性以及decoration属性，“两个只能存在一个”。
                     */
                    color: Colors.purple,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                  ),
                  child: new InkWell(
                    borderRadius: new BorderRadius.circular(20.0),
                    //给水波纹也设置同样的圆角
                    onTap: () {
                      print(
                          '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
                    },
                    child: new Container(
                      width: 300.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ),
            new Center(
              child: new Material(
                child: new Ink(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
                  ),
                  child: new InkResponse(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(30.0)),
//                  highlightColor: Colors.yellowAccent,//点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                    highlightShape: BoxShape.rectangle,
                    //点击或者toch控件高亮的shape形状
                    //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                    radius: 300.0,
                    //水波纹的半径
                    splashColor: Colors.black,
                    //水波纹的颜色
                    containedInkWell: true,
                    //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                    onTap: () {
                      print(
                          '！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！');
                    },
                    child: new Container(
                      //1.不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                      width: 300.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  onTap() {
    print("button click");
  }
}

//自定义按钮/渐变色按钮
class GradientButton extends StatelessWidget {
  GradientButton(
      {@required this.child, this.colors, this.width, this.height, this.onTap});

  final Widget child; //子控件

  final double width; //宽
  final double height; //高

  final List<Color> colors; //渐变色组
  final GestureTapCallback onTap; //点击回调

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ??
        [
          themeData.primaryColor,
          themeData.primaryColorDark ?? themeData.primaryColor
        ];

    // TODO: implement build
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

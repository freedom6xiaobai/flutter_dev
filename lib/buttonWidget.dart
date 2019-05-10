import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class buttonWidget extends StatelessWidget {
  //高亮点击
  ValueChanged<bool> onHighlightChanged(BuildContext context) {
    return (bool b) {
      showToast(context, "onHighlightChanged:" + b.toString());
    };
  }

  //回调
  VoidCallback pressedBtn(BuildContext context) {
    return () {
      showToast(context, "pressedBtn");
    };
  }

  //提示
  void showToast(BuildContext context, var msg) async {
    Widget _buildToastWidget() {
      return Center(
        child: Card(
          color: Colors.black26,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    //创建OverlayEntry
    OverlayEntry overlayEntry = OverlayEntry(
      //toast靠它加到屏幕上
      builder: (BuildContext context) => Positioned(
        //top值，可以改变这个值来改变toast在屏幕中的位置
        top: MediaQuery.of(context).size.height * 4 / 7,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: _buildToastWidget(),
          ),
        ),
      )
    );
    overlayState.insert(overlayEntry); //显示到屏幕上。
    await Future.delayed(Duration(seconds: 2));//等待2秒
    overlayEntry.remove(); //移除
  }


//1。主按钮
  Widget getMaterialButton(BuildContext context) {
    return MaterialButton(
      key: ValueKey("text"),
      child: Text("MaterialButton"),
      onPressed: pressedBtn(context),
      onHighlightChanged: onHighlightChanged(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.red,
      disabledTextColor: Colors.black12,
      color: Colors.orangeAccent,
      disabledColor: Colors.grey,
      highlightColor: Colors.grey,
      splashColor: Colors.black12,
      //
      colorBrightness: Brightness.light,
      elevation: 10,
      highlightElevation: 10,
      disabledElevation: 10,
      padding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Colors.pink, style: BorderStyle.solid, width: 5)),
      clipBehavior: Clip.antiAlias,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      animationDuration: Duration(seconds: 1),
      minWidth: 200,
      height: 50,
    );
  }

//2。第二行按钮
  Widget getRaisedButtonRow(BuildContext context) {
    return new Row(children: [
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getRaisedButton(context)),
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getRaisedButtonIcon(context)),
      SizedBox(width: 10),
    ]);
  }

//2-1。左侧按钮
  Widget getRaisedButton(BuildContext context) {
    return RaisedButton(
      child: Text("RaisedButton"),
      onPressed: pressedBtn(context),
      onHighlightChanged: onHighlightChanged(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.blue,
      disabledTextColor: Colors.red,
      color: Color(0xFF82B1FF),
      disabledColor: Colors.grey,
      highlightColor: Colors.grey,
      // 按下的背景色
      splashColor: Colors.green,
      // 水波纹颜色
      colorBrightness: Brightness.light,
      // 主题
      elevation: 10,
      highlightElevation: 10,
      disabledElevation: 10,
      padding: EdgeInsets.all(10),
      // RaisedButton 才起效
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Colors.pink, style: BorderStyle.solid, width: 5)),
      clipBehavior: Clip.antiAlias,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      animationDuration: Duration(seconds: 1),
    );
  }

//2-2。右侧加图片按钮
  Widget getRaisedButtonIcon(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.bookmark_border),
      label: Text("RaisedButton"),
      onPressed: pressedBtn(context),
      onHighlightChanged: onHighlightChanged(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.blue,
      disabledTextColor: Colors.red,
      color: Color(0xFF82B1FF),
      disabledColor: Colors.orangeAccent,
      highlightColor: Colors.brown,
      colorBrightness: Brightness.light,
      // 主题
      elevation: 10,
      highlightElevation: 10,
      disabledElevation: 10,
      // RaisedButton 才起效
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Colors.cyan[200], style: BorderStyle.solid, width: 5)),
      clipBehavior: Clip.antiAlias,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      animationDuration: Duration(seconds: 1),
    );
  }

//3。第三行按钮
  Widget getFlatButtonRow(BuildContext context) {
    return new Row(children: [
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getFlatButton(context)),
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getFlatButtonIcon(context)),
      SizedBox(width: 10),
    ]);
  }

//3-1。左侧按钮
  Widget getFlatButton(BuildContext context) {
    return FlatButton(
      child: Text("FlatButton"),
      onPressed: pressedBtn(context),
      onHighlightChanged: onHighlightChanged(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.yellow,
      disabledTextColor: Colors.red,
      color: Color(0xFF82B1FF),
      disabledColor: Colors.grey,
      highlightColor: Colors.grey,
      // 按下的背景色
      splashColor: Colors.transparent,
      // 水波纹颜色
      colorBrightness: Brightness.light,
      padding: EdgeInsets.all(10),
//       RaisedButton 才起效
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Color(0xFFF9F3FF), style: BorderStyle.solid, width: 2)),
      clipBehavior: Clip.antiAlias,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

//3-2。右侧按钮
  Widget getFlatButtonIcon(BuildContext context) {
    return FlatButton.icon(
      icon: Icon(
        Icons.menu,
        color: Colors.green,
      ),
      label: Text("FlatButton"),
      onPressed: pressedBtn(context),
      onHighlightChanged: onHighlightChanged(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.yellow,
      disabledTextColor: Colors.red,
      color: Color(0xFF82B1FF),
      disabledColor: Colors.grey,
      highlightColor: Colors.red,
      // 按下的背景色
      splashColor: Colors.green,
      // 水波纹颜色
      colorBrightness: Brightness.light,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
              color: Color(0xFF6FFF00), style: BorderStyle.solid, width: 2)),
      clipBehavior: Clip.antiAlias,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

//4。第4行按钮
  Widget getOutlineButtonRow(BuildContext context) {
    return new Row(children: [
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getOutlineButton(context)),
      SizedBox(width: 10),
      new Expanded(flex: 1, child: getOutlineButtonIcon(context)),
      SizedBox(width: 10),
    ]);
  }

//4-1。左侧按钮
  Widget getOutlineButton(BuildContext context) {
    return OutlineButton(
      child: Text("OutlineButton"),
      onPressed: pressedBtn(context),
      textTheme: ButtonTextTheme.accent,
      textColor: Colors.blueAccent,
      disabledTextColor: Colors.red,
      color: Colors.purple[900],
      highlightColor: Color(0xFF2962FF),
      // 按下的背景色
      splashColor: Colors.red,
      // 水波纹颜色
      highlightElevation: 10,
      padding: EdgeInsets.all(10),
//       RaisedButton 才起效
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(
              color: Colors.white, style: BorderStyle.solid, width: 2)),
      clipBehavior: Clip.antiAlias,
    );
  }

//4-2。右侧按钮
  Widget getOutlineButtonIcon(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(
        Icons.menu,
        color: Colors.green,
      ),
      label: Text("OutlineButton"),
      onPressed: pressedBtn(context),
      textTheme: ButtonTextTheme.normal,
      textColor: Colors.yellow,
      disabledTextColor: Colors.red,
      color: Color(0xFF82B1FF),
      highlightColor: Colors.red,
      // 按下的背景色
      splashColor: Colors.green,
      // 水波纹颜色
//      elevation: 10,
      highlightElevation: 10,
      padding: EdgeInsets.all(10),
      // RaisedButton 才起效
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

//iOS 按钮
  Widget getCupertinoButton(BuildContext context) {
    return CupertinoButton(
      child: Text("CupertinoButton"),
      onPressed: pressedBtn(context),
      color: Colors.blue,
      disabledColor: Colors.grey,
      padding: EdgeInsets.all(10),
      minSize: 50,
      pressedOpacity: 0.8,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("各种按钮"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(flex: 0, child: getMaterialButton(context)),
          SizedBox(height: 10),
          Expanded(flex: 0, child: getRaisedButtonRow(context)),
          SizedBox(height: 10),
          Expanded(flex: 0, child: getFlatButtonRow(context)),
          SizedBox(height: 10),
          Expanded(flex: 0, child: getOutlineButtonRow(context)),
          SizedBox(height: 10),
          Expanded(flex: 0, child: getCupertinoButton(context)),
          SizedBox(height: 10),
          Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.blue,
            elevation: 5.0,
            color: Colors.blue,
            child: new MaterialButton(
              height: 10,
              onPressed: () {},
              minWidth: 160.0,
              color: Colors.blue,
              child: Text(
                'Buy Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {},
            color: Colors.red,
            shape: const RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(50)),
//                borderRadius: BorderRadius.all(Radius.circular(20)),
//                side: BorderSide(color: Colors.pink, style: BorderStyle.solid,width:5)
            ),
            height: 100,
          )
        ],
      ),
    );
  }
}

/*
Row(
        children: <Widget>[
            new RaisedButton(
              onPressed: () {
                print('点击红色按钮事件');
              },
              color: const Color(0xffcc0000),
              child: new Text('红色按钮'),
            ),
            new Expanded(//Expanded整屏幕宽拉/Flexible 适配拉
              flex: 1,
              child: new RaisedButton(
                onPressed: () {
                  print('点击黄色按钮事件');
                },
                color: const Color(0xfff1c232),
                child: new Text('黄色按钮'),
              ),
            ),
            new RaisedButton(
              onPressed: () {
                print('点击粉色按钮事件');
              },
              color: const Color(0xffea9999),
              child: new Text('粉色按钮'),
            ),
          ]
      )
 */

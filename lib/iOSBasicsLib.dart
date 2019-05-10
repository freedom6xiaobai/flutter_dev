import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 声明文本样式
const textStyle = const TextStyle(
  fontFamily: 'Raleway',
);

// 使用文本样式
var buttonText = const Text(
  "Use the font for this text",
  style: textStyle,
);

// ignore: camel_case_types
class iOSBaseVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    DefaultTextStyle(
      //1.设置文本默认样式
      style: TextStyle(
        color: Colors.red,
        fontSize: 20.0,
      ),
      textAlign: TextAlign.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("hello world"),
          Text("I am Jack"),
          Text(
            "I am Jack",
            style: TextStyle(
                inherit: false, //2.不继承默认样式
                color: Colors.grey),
          ),
        ],
      ),
    );

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("iOS风格控件"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              onPressed: () {
                print("dd");
              },
              child: Text("点击"),
              color: Colors.lightBlueAccent,
            ),
            Text(
              "Hello world",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              "Hello world! I'm Jack. " * 4,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.0),
            ),
            Text(
              "Hello world",
              textScaleFactor: 1.5,
              style: TextStyle(fontSize: 12.0),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: "Home: ",
                style: TextStyle(fontSize: 12.0),
              ),
              TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(color: Colors.blue, fontSize: 12.0),
                  recognizer: null),
            ]))
          ],
        ));
  }
}

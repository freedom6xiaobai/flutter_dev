import 'package:flutter/material.dart';

class StackLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("层叠布局Stack"),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
            fit: StackFit.expand, //未定位widget占满Stack整个空间
            children: <Widget>[
              Chip(
                label: Text("按钮"),
                avatar: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text("A"),
                ),
              ),
              Positioned(
                left: 20.0,
                top: 20.0,
                child: Container(
                  child: Text("Hello world",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
//              Container(
//                color: Colors.orangeAccent,
//              ),
              Positioned(
                left: 18.0,
                child: Text("I am Jack"),
              ),
              Positioned(
                top: 18.0,
                child: Text("Your friend"),
              )
            ],
          ),
        ));
  }
}

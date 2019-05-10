import 'package:flutter/material.dart';

class DecoratedBoxTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("装饰容器DecoratedBox"),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.orangeAccent,Colors.purple]),
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.green,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 100.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.cyanAccent),
            ),
          ),
        ));
  }
}

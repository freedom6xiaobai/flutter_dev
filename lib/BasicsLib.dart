import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("基础库的使用/按钮"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.red,
            child: Text("dd"),
          ),
          Expanded(
            child: Text("dd"),
          ),
          RaisedButton(
            child: Text("normal"),
            onPressed: () => {},
          ),
          FlatButton(
            child: Text("normal"),
            onPressed: () => {},
          ),
          OutlineButton(
            child: Text("normal"),
            onPressed: () => {},
          ),
          IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () => {},
          ),
          FlatButton(
            color: Colors.blue,
            highlightColor: Colors.blue[700],
            colorBrightness: Brightness.dark,
            splashColor: Colors.grey,
            child: Text("Submit"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () => {},
          ),
          RaisedButton(
            color: Colors.red,
            highlightColor: Colors.yellow,
            colorBrightness: Brightness.light,
            splashColor: Colors.black,
            child: Text("按钮"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          ),
          OutlineButton(
            color: Colors.red,
            highlightColor: Colors.lightGreenAccent,
            splashColor: Colors.red,
            disabledBorderColor: Colors.green,
            highlightedBorderColor: Colors.cyan,
            child: Text("按钮"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}


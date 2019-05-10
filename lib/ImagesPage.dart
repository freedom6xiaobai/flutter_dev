import 'package:flutter/material.dart';

class MyIcons {
  // book 图标
  static const IconData book = const IconData(0xe865,
      fontFamily: 'MaterialIcons', matchTextDirection: true);

  // 微信图标
  static const IconData wechat = const IconData(0xe3a5,
      fontFamily: 'MaterialIcons', matchTextDirection: true);
}

class ImagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("图片加载/单复选框"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Image(
//            image: AssetImage("Images/0.jpg"),
//            width: 100.0,
//            height: 100.0,
//            fit: BoxFit.cover,
//          ),
//          Image(
//            image: NetworkImage("http://localhost/Images/beautiful.jpg"),
//            width: 100.0,
//            height: 100.0,
//            fit: BoxFit.cover,
//          ),
          Image.asset(
            'Images/1.jpg',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Image.network(
            "http://localhost/Images/watch.jpg",
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Image.asset(
            "Images/2.jpg",
            width: 100.0,
            height: 100.0,
            color: Colors.yellow,
            colorBlendMode: BlendMode.darken,
            repeat: ImageRepeat.repeatY,
          ),
          Icon(
            MyIcons.book,
            color: Colors.orange,
          ),
          Icon(
            MyIcons.wechat,
            color: Colors.orangeAccent,
          ),
          SwitchAndCheckBoxWidget()
        ],
      ),
    );
  }
}

class SwitchAndCheckBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SwitchAndCheckBoxWidgetState();
  }
}

class SwitchAndCheckBoxWidgetState extends State<SwitchAndCheckBoxWidget> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  //  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          activeColor: Colors.red,
          inactiveThumbColor: Colors.yellow,//关闭
          inactiveTrackColor: Colors.red[50],//打开
          inactiveThumbImage: NetworkImage('http://localhost/Images/watch.jpg'),
          activeThumbImage: NetworkImage('http://localhost/Images/watch.jpg'),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          value: _switchSelected, //当前状态
          onChanged: (bool value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected, //选中时的颜色
          onChanged: (bool value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        )
      ],
    );
  }
}
//.activeColor,
//    this.activeTrackColor,
//    this.inactiveThumbColor,
//    this.inactiveTrackColor,
//    this.activeThumbImage,
//    this.inactiveThumbImage,
//    this.materialTapTargetSize,
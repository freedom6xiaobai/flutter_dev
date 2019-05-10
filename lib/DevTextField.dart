import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('输入框textfield'),
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

class ContentPageState extends State<ContentPage> {
  //两种取值，vc取值，元素取值
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _mailController = TextEditingController();
  String name;

  //焦点控制
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  void initState() {
    //两种监听文本变化/vc监听/onChanged监听
    _nameController.addListener(() {
      print(_nameController.text);
    });

    // 监听焦点变化
    focusNode1.addListener(() {
      print("焦点1跳走了");
      print(focusNode1.hasFocus);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //设置默认值，并从第三个字符开始选中后面的字符
    _mailController.text = "hello world!";
    _mailController.selection = TextSelection(
        //baseOffset位置，extentOffset长度
        baseOffset: 2,
        extentOffset: _mailController.text.length);

//    Theme(
//  data: Theme.of(context).copyWith(
//      hintColor: Colors.grey[200], //定义下划线颜色
//      inputDecorationTheme: InputDecorationTheme(
//          labelStyle: TextStyle(color: Colors.grey),//定义label字体样式
//          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)//定义提示文本样式
//      )
//  ),

    // TODO: implement build
    return Column(
      children: <Widget>[
        TextField(
          controller: _nameController,
          autofocus: true,
          focusNode: focusNode1,
          //关联焦点1
          maxLength: 10,
          maxLengthEnforced: false,
          decoration: InputDecoration(
              labelText: "用户名:",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person)),
          style: TextStyle(fontSize: 12.0, color: Colors.black26),
          cursorWidth: 100.0,
          cursorRadius: Radius.circular(30),
          cursorColor: Colors.red,
          onChanged: (text) {
            name = text;
          },
        ),
        TextField(
          controller: _passController,
          obscureText: true,
          focusNode: focusNode2,
          //关联焦点2
          maxLength: 33,
          decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock)),
          onChanged: (text) {
            print(_passController.text);
          },
          onEditingComplete: () {
            print("onEditingComplete");
          },
          onSubmitted: (text) {
            print(text + "onSubmitted");
          },
        ),
        TextField(
          controller: _mailController,
          decoration: InputDecoration(
              labelText: "邮件",
              hintText: "您的邮箱地址",
              prefixIcon: Icon(Icons.mail),
              border: InputBorder.none),
        ),
        Container(
          decoration: BoxDecoration(
              // 下滑线浅灰色，宽度1像素
              border: Border(
                  bottom: BorderSide(color: Colors.grey[200], width: 1.0))),
          child: TextField(
            decoration: InputDecoration(
                labelText: "自定义样式",
                hintText: "个性输入框",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.new_releases)),
          ),
        ),
        RaisedButton(
          child: Text("移动焦点"),
          onPressed: () {
            //将焦点从第一个TextField移到第二个TextField
            // 这是一种写法
            FocusScope.of(context).requestFocus(focusNode2);
            // 这是第二种写法
//            if (null == focusScopeNode) {
//              focusScopeNode = FocusScope.of(context);
//            }
//            focusScopeNode.requestFocus(focusNode2);
          },
        ),
        RaisedButton(
          child: Text("隐藏键盘"),
          onPressed: () {
            // 当所有编辑框都失去焦点时键盘就会收起
            focusNode1.unfocus();
            focusNode2.unfocus();
          },
        )
      ],
    );
  }
}

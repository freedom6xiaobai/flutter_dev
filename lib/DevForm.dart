import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Form表单"),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: nameController,
                  autofocus: true,
                  maxLength: 8,
                  decoration: InputDecoration(
                      hintText: "用户名", prefixIcon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    return v.trim().length > 0 ? null : "用户名不能为空";
                  }),
              TextFormField(
                  controller: passController,
                  obscureText: false,
                  maxLength: 12,
                  decoration: InputDecoration(
                      hintText: "密码", prefixIcon: Icon(Icons.lock)),
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              Builder(
                //注意，登录按钮的onPressed方法中不能通过Form.of(context)来获取，原因是，
                // 此处的context为ContentPage的context，
                // 而Form.of(context)是根据所指定context向根去查找，
                // 而FormState是在FormTestRoute的子树中，所以不行。
                // 正确的做法是通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数：
                builder: (context) => Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        child: Text("登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //在这里不能通过此方式获取FormState，context不对
                          print(Form.of(context));
                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            print("验证通过提交数据");
                          }
                        },
                      ),
                    ),
              )
            ],
          )),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
    );
  }
}

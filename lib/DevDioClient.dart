import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DevDioClientTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("第三方网络库 Dio http库"),
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
  String text = "";
  List dataArray = [];

  //网络请求
  void requestData() async {
    Dio dio = Dio();
    Response response;
    response = await dio.get("http://localhost/Object/tv.json");
    print(response.data.toString());
    text = response.data.toString();

    ///对于GET请求我们可以将query参数通过对象来传递，上面的代码等同于：
    response =
        await dio.get("/test", queryParameters: {"id": 12, "name": "wendu"});
    print(response);

    //发起一个 POST 请求:
    response = await dio.post("/test", data: {"id": 12, "name": "wendu"});
    //发起多个并发请求:
    response =
        (await Future.wait([dio.post('/info'), dio.get("/token")])) as Response;
    //下载文件:
    response = await dio.download("https://www.google.com/", "保存地址");
    //发送 FormData:
    FormData formData = new FormData.from({
      "name": "wendux",
      "age": 25,
    });
    response = await dio.post("/info/", data: formData);

    //通过FormData上传多个文件:
    FormData formData1 = FormData.from({
      "name": "wendux",
      "age": 25,
      "file1": UploadFileInfo(File("./upload.txt"), "upload1.txt"),
      "file2": UploadFileInfo(File("./upload.txt"), "upload2.txt"),
      // 支持文件数组上传
      "files": [
        UploadFileInfo(File("./example/upload.txt"), "upload.txt"),
        UploadFileInfo(File("./example/upload.txt"), "upload.txt")
      ]
    });
    response = await dio.post("/info", data: formData1);
  }

  //网络请求1
  void requestData1() async {
    var httpClinet = HttpClient();
    var url = Uri.parse('https://zjc477.xyz/ds.json');
    var request = await httpClinet.getUrl(url);
    var response = await request.close();
    String responseBody = await response.transform(utf8.decoder).join();
//    print(responseBody);
    Map map = json.decode(responseBody);
//    print('${map["channels"]}');
    setState(() {
      dataArray = map["channels"];
      print(dataArray);
    });

    print(dataArray);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      requestData1();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: dataArray.length,
//      itemExtent: 30.0,
      itemBuilder: (BuildContext context, int index) {
        Map map = dataArray[index];
        TVModel model = TVModel.fromJson(map);
        return GestureDetector(
          onTap: () {
            _showAlert(model.name, model.url);
//            _showAlert('${map['name']}', '${map['url']}');
          },
          child: ListTile(
//            title: Text('${map['name']}'),
//            subtitle: Text('${map['url']}'),
            title: Text(model.name),
            subtitle: Text(model.url),
          ),
        );
      },
    );
  }

  //警告框
  Future<void> _showAlert(@required String title, String subtitle) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: <Widget>[
              new CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
              new CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('确认')),
            ],
          );
        });
  }
}

class TVModel {
  final String name;
  final String url;

  TVModel(this.name, this.url);

  TVModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name, 'url': url};
}

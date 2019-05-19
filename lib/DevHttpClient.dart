import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class DevHttpClientTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("网络请求"),
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

  //MARK:创建网络请求
  void requestData(@required Uri url) async {
    try {
      //请求
      SecurityContext sc = SecurityContext();
      String file = "证书地址";
      sc.setTrustedCertificates(file); ////file为证书路径
      HttpClient httpClient = HttpClient(context: sc);

      //创建一个httpclient
      HttpClient _httpClient = HttpClient();
      //证书验证
      String PEM = "AJDFKLJAKLSFJLKAJ!JKLJH#JHJK@HJKHJKH@JKJ"; //文件读取
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //X509Certificate是证书的标准格式，包含了证书除私钥外所有信息
        if (cert.pem == PEM) {
          return true; //证书一致，则允许发送数据
        }
        return false;
      };

      //基本配置
      _httpClient.idleTimeout = Duration(seconds: 15); //保持活动时间
      _httpClient.connectionTimeout = Duration(seconds: 30); //超时
      _httpClient.maxConnectionsPerHost = 1; //同一个host，同时允许建立连接的最大数量。

      //认证
      //一个建议是，如果所有请求都需要认证，
      // 那么应该在HttpClient初始化时就调用addCredentials()来添加全局凭证，而不是去动态添加。
//      _httpClient.addCredentials(url, "admin", HttpClientBasicCredentials("username","password"));//Basic认证凭据
      _httpClient.addCredentials(url, "admin",
          HttpClientDigestCredentials("username", "password")); //Digest认证凭据
      _httpClient.authenticate = (Uri url, String scheme, String realm) async {
        if (url.host == "xx.com" && realm == "admin") {
          _httpClient.addCredentials(
              url, realm, HttpClientBasicCredentials("username", "password"));
          return true;
        }
        return false;
      };

      //代理,所有请求通过代理服务器
      _httpClient.findProxy = (url) {
        // 如果需要过滤uri，可以手动判断
        return "PROXY 172.18.4.145:8888";
      };
      _httpClient.addProxyCredentials("172.18.4.145", 9999, "admin",
          HttpClientBasicCredentials("username", "pasword"));

      //打开http链接
      HttpClientRequest request = await _httpClient.getUrl(url);
      //使用iPhone的UA
//      request.headers.add("User-agent", "");
      //等待连接服务器（发送请求给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      String string = await response.transform(utf8.decoder).join();
      //输出响应头
      print(string);
      text = string;
      //关闭client后，通过改client发起的所有请求都会终止
      _httpClient.close();
    } catch (e) {
      print("请求失败" + e);
    } finally {
      setState(() {
        print("请求结束");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      requestData(Uri.parse("http://localhost/Object/tv.json"));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              color: Colors.red[(index % 9 + 1) * 100],
              child: SingleChildScrollView(
                child: Text(text),
              ),
            ),
          );
        });
  }
}

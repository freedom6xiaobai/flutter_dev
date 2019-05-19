import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class DevWebSocketsTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ContentPage();
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
  TextEditingController controller = TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //创建websocket连接
    channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Form(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Sender message'),
                controller: controller,
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: " + snapshot.data;
                }
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        tooltip: "sender message",
        onPressed: senderMessage,
      ),
    );
  }

  //method event
  //发送消息事件
  void senderMessage() {
    channel.sink.add(controller.text);
  }
}

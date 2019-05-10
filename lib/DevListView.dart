import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class DevListViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: ContentPage());
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
  static const lodingTag = "##lodingTag##"; //表尾标记
  var dataArray = <String>[lodingTag];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reuestLoadData();
  }

  void _reuestLoadData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      //每次生成20个单词
      dataArray.insertAll(dataArray.length - 1,
          generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {
        //重构
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.red);
    Widget divider2 = Divider(color: Colors.green);

    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListTile(title: Text("商品列表")),
        ), //头
        Expanded(
          child: ListView.separated(
            //列表
            itemCount: dataArray.length,
            itemBuilder: (BuildContext context, int index) {
              if (dataArray[index] == lodingTag) {
                if (dataArray.length - 1 < 100) {
                  _reuestLoadData(); //获取数据
                  return Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  );
                } else {
                  //已经加载了100条
                  return Container(
                    alignment: Alignment.center,
                    child:
                        Text("没有更多加载", style: TextStyle(color: Colors.black26)),
                    padding: EdgeInsets.all(10),
                  );
                }
              }

              return ListTile(
                title: Text("items:" + dataArray[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              // //分割器构造器
              return index % 2 == 0 ? divider1 : divider2;
            },
          ),
        )
      ],
    );
  }
}

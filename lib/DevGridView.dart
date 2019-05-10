import 'package:flutter/material.dart';

class DevGridViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
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
  List<IconData> dataArray = []; //保存Icon数据

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestIconData();
  }

  //请求数据
  void _requestIconData() {
    Future.delayed(Duration(milliseconds: 2)).then((e) {
      setState(() {
        dataArray.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: GridView(
              children: <Widget>[
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.cake),
                Icon(Icons.alarm)
              ],
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //该子类实现了一个横轴为固定数量子元素的layout算法
                  //crossAxisCount：横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了,即ViewPort横轴长度/crossAxisCount。
                  //mainAxisSpacing：主轴方向的间距。
                  //crossAxisSpacing：横轴方向子元素的间距。
                  //childAspectRatio：子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
                  crossAxisCount: 3, //横轴三个子widget
                  childAspectRatio:
                      1.5 //宽高比为1时，子widget ,height * ratio = contentWidth

                  ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              color: Colors.red,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 3.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                color: Colors.cyanAccent,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      //该子类实现了一个横轴子元素为固定最大长度的layout算法
                      // maxCrossAxisExtent为子元素在横轴上的最大长度，之所以是“最大”长度,
                      //是因为横轴方向每个子元素的长度仍然是等分的，
                      // 举个例子，如果ViewPort的横轴长度是450，
                      // 那么当maxCrossAxisExtent的值在区间[450/4，450/3)内的话，
                      // 子元素最终实际长度都为112.5，而childAspectRatio所指的子元素横轴和主轴的长度比为最终的长度比。
                      maxCrossAxisExtent: 50.0,
                      childAspectRatio: 1.5 ////宽高比为2
                      ),
                  children: <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ],
                )),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              color: Colors.yellow,
              child: GridView.extent(
                //快速的创建纵轴子元素为固定最大长度的的GridView ,不用使用代理
                maxCrossAxisExtent: 50.0,
                childAspectRatio: 4.0,
                children: <Widget>[
                  Icon(Icons.ac_unit),
                  Icon(Icons.airport_shuttle),
                  Icon(Icons.all_inclusive),
                  Icon(Icons.beach_access),
                  Icon(Icons.cake),
                  Icon(Icons.free_breakfast),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              color: Colors.amber,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, //每行三列
                      childAspectRatio: 2.0 //显示区域宽高相等
                      ),
                  itemCount: dataArray.length,
                  itemBuilder: (context, index) {
                    //如果显示到最后一个并且Icon总数小于200时继续获取数据
                    if (index == dataArray.length - 1 &&
                        dataArray.length < 200) {
                      _requestIconData();
                    }
                    return Icon(dataArray[index]);
                  }),
            ),
          ),
        )
      ],
    );
  }
}

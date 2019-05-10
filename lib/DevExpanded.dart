import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class FlexLayoutTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("弹性布局Expanded"),
      ),
      body: Column(
        children: <Widget>[
          Flex(
            //Flex的两个子widget按1：2来占据水平空间
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                  height: 50.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.yellow,
                  height: 50.0,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: SizedBox(
              height: 70,
              //Flex的三个子widget，在垂直方向按3：2：2来占用100像素的空间
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.cyanAccent,
                      height: 30.0,
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      height: 30.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100.0,
            color: Colors.purple,
            child: Wrap(
              spacing: 10.0, // 主轴(水平)方向间距
              runSpacing: 10.0, // 纵轴（垂直）方向间距
              children: <Widget>[
                Chip(
                  label: Text("芯片1"),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: Text("A"),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.cyanAccent, fontSize: 12.0),
                ),
                Chip(
                  label: Text("芯片2"),
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage("Images/5.jpg"),
                  ),
                ),
                Chip(
                  label: Text("芯片3"),
                  avatar: CircleAvatar(
                    child: Text("B"),
                  ),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: new BorderSide(
                        style: BorderStyle.none,
                      )),
                ),
                Chip(
                  label: Text("芯片4"),
                  deleteIcon: Icon(Icons.delete),
                  deleteButtonTooltipMessage: "ddd",
                  onDeleted: () {},
                ),
                Chip(
                  label: Text("芯片5"),
                  deleteIcon: Icon(Icons.delete),
                  deleteButtonTooltipMessage: "ddd",
                  onDeleted: () {},
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              height: 220.0,
              color: Colors.black12,
              child: Builder(
                builder: (context) => Flow(
                      children: <Widget>[
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.red,
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.green,
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.yellow,
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          color: Colors.purple,
                        ),
//                        Container(
//                          width: 80.0,
//                          height: 80.0,
//                          color: Colors.orangeAccent,
//                        ),
                      ],
                      delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
                    ),
              ))
        ],
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
//            transform: Matrix4.compose(
//                Vector.Vector3(x, y, 0.0),
//                Vector.Quaternion(0.0, 0.0, 0.3, 0.1),
//                Vector.Vector3(1.0, 1.0, 1.0))
            transform: Matrix4.translationValues(x, y, 0.0)
            );
        x = w + margin.left;
      } else {
        x = margin.left;
        y += 80 + margin.top + margin.bottom;
//        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  getSize(BoxConstraints constraints) {
    //指定Flow的大小
    return Size(double.infinity, double.infinity);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DevExampleTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ContentPage();
  }
}

//内容
class ContentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentPageState();
  }
}

class ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

//定义一个globalKey, 由于GlobalKey要保持全局唯一性，我们使用静态变量存储
  static GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  //navBtnlist
  TabController _tabController; //需要定义一个Controller
  List _tabs = ["新闻", "历史", "图片"];

  //page切换
  var _contentPage = [Text("a"), Text("b"), Text("c"), Text("d")];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 创建Controller
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          {
            print("新闻");
          }
          break;
        case 1:
          {
            print("历史");
          }
          break;
        case 2:
          {
            print("图片");
          }
          break;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _globalKey,
      //设置key
      appBar: AppBar(
        title: Text("例子"),
        leading: Builder(
          builder: (context) => IconButton(
                onPressed: () {
                  // 打开抽屉菜单
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.dashboard),
              ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _globalKey.currentState.openDrawer();
            },
            icon: Icon(Icons.share),
          )
        ],
        bottom: TabBar(
            //导航栏
            controller: _tabController,
            indicatorColor: Colors.yellow,
            unselectedLabelColor: Colors.cyanAccent,
            tabs: _tabs.map((e) => Tab(text: e)).toList()),
      ),
      drawer: MyDrawer(),
      //抽屉
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((e) => Container(alignment: Alignment.center,child: Text(e,textScaleFactor: 5,),)).toList(),
//        _tabs.map((e) {
//          //创建3个Tab页
//          return Container(
//            alignment: Alignment.center,
//            child: Text(e, textScaleFactor: 5),
//          );
//        }).toList(),
      ),
      //Center(child: _contentPage[_selectedIndex]),
//      bottomNavigationBar: BottomNavigationBar(
//        // 底部导航
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//              backgroundColor: Colors.orangeAccent[100]),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.business),
//              title: Text('Business'),
//              backgroundColor: Colors.deepOrangeAccent),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.school),
//              title: Text('School'),
//              backgroundColor: Colors.pink),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.person),
//              title: Text('Mine'),
//              backgroundColor: Colors.yellow),
//        ],
//        type: BottomNavigationBarType.fixed,
//        iconSize: 24.0,
//        currentIndex: _selectedIndex,
//        fixedColor: Colors.blue,
//        onTap: (int newIndex) {
//          setState(() {
//            _selectedIndex = newIndex;
//          });
//        },
//      ),
      bottomNavigationBar: BottomAppBar(
        //底部tabbar
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {

              },
            ),
            SizedBox(), //中间位置空出
            IconButton(
              icon: Icon(Icons.business),
              onPressed: () {},
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      //tabbar 中心➕按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

//抽屉效果view

class MyDrawer extends StatelessWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                //顶部头像/名称
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("Images/9.jpg"),
                                fit: BoxFit.cover)),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Text("我的名称"),
                      alignment: Alignment.centerLeft,
                    ),
                  )
                ],
              ),
              Row(
                //简介
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Icon(Icons.add)),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text("这是一个简介"),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                        title: Text("Items:{$index}"),
                        subtitle: Text("描述"),
                        trailing: RaisedButton(
                          child: Text("关注"),
                          onPressed: () {},
                        ),
                      );
                    },
                  ),
                ),
              ),

            ],
          )),
    );
  }
}


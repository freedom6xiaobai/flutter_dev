import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DevCustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.yellow,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("你白大爷"),
              background: Image.network(
                "http://localhost/Images/beautiful.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  color: Colors.cyan[(index % 9 + 1) * 100],
                  child: Text('Item $index'),
                );
              }, childCount: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate((context,index){
              return Container(
                color: Colors.red[(index % 9 + 1) * 100],
                alignment: Alignment.center,
                child: Text("list: $index"),
              );
            },childCount: 4),
            itemExtent: 30,
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              crossAxisCount: 10,
              childAspectRatio: 1.0,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 0.0,
              children: <Widget>[
                Container(color: Colors.yellow,),
                Container(color: Colors.red,),
                Container(color: Colors.yellow,),
                Container(color: Colors.red,),
                Container(color: Colors.yellow,),
                Container(color: Colors.red,),
                Container(color: Colors.yellow,),
                Container(color: Colors.red,),
              ],

            ),
          )
        ],
      ),
    );
  }
}

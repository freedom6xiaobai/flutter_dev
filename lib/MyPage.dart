import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TapboxAState();
  }
}

class TapboxAState extends State<TapboxA> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("page"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              //单独管理状态
              onTap: () {
                setState(() {
                  _active = !_active;
                });
              },
              child: Container(
                  width: 100.0,
                  height: 100.0,
                  color: _active ? Colors.green : Colors.grey,
                  child: Center(
                    child: Text(
                      _active ? "active" : "inactive",
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(color: Colors.red, fontSize: 12.0),
                    ),
                  )),
            ),
            _ParentWidget(),
            _MixtureParentWidget()
          ],
        ));
  }
}

//1.子控件无状态/父控件管理状态
class _ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<_ParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100.0,
      color: Colors.blue,
      child: FirstButton(
        onChanged: (bool active) {
          setState(() {
            _active = active;
          });
        },
        active: _active,
      ),
    );
  }
}

// ignore: must_be_immutable
class FirstButton extends StatelessWidget {
  FirstButton({Key key, this.active: false, @required this.onChanged})
      : super(key: key);
  bool active;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        onChanged(!active);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: active ? Colors.yellow : Colors.orange,
        child: Text(
          active ? "active" : "inactive",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//2.混合管理状态
class _MixtureParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MixtureParentWidgetState();
  }
}

class _MixtureParentWidgetState extends State<_MixtureParentWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Container(
          height: 100.0,
          width: 300.0,
          color: _active ? Colors.brown[200] : Colors.brown,
          child: _mixtureButton(
            onChanged: (bool active) {
              setState(() {
                _active = active;
              });
            },
            active: _active,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
        )
      ],
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _mixtureButton extends StatefulWidget {
  _mixtureButton({Key key, this.active: false, @required this.onChanged})
      : super(key: key);
  bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _mixtureButtonState();
  }
}

// ignore: camel_case_types
class _mixtureButtonState extends State<_mixtureButton> {
  bool _highlight = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChanged(!widget.active);
        });
      },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _highlight = !_highlight;
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//        color: widget.active ? Colors.deepOrange : Colors.deepPurple,
        child: Text(widget.active ? "1111111" : "222222"),
        decoration: BoxDecoration(
            border: Border.all(
                color: _highlight ? Colors.teal[200] : Colors.teal,
                width: 5.0
            )
        ),
      ),
    );
  }
}

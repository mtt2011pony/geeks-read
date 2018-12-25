import 'package:flutter/material.dart';
import 'package:geeks_read/pages/EnNewsPage.dart';
import 'package:geeks_read/pages/SubscribePage.dart';
import 'package:geeks_read/pages/ZhNewsPage.dart';

class GeeksReadApp extends StatefulWidget {
  @override
  _GeeksReadAppState createState() => new _GeeksReadAppState();
}

class _GeeksReadAppState extends State<GeeksReadApp>
    with TickerProviderStateMixin {

  int _tabIndex = 0;
  List<BottomNavigationBarItem> _navigationViews;
  var appBarTitles = ['中文新闻', '英文新闻', '邮件订阅'];
  var _body;

  initData() {
    _body = new IndexedStack(
      children: <Widget>[
        new ZhNewsPage(),
        new EnNewsPage(),
        new SubscribePage()
      ],
      index: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return new MaterialApp(
      navigatorKey: navigatorKey,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(appBarTitles[_tabIndex]),
        ),
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items: _navigationViews
              .map((BottomNavigationBarItem navigationView) => navigationView)
              .toList(),
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
        resizeToAvoidBottomPadding: false,

      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          title: new Text(appBarTitles[0]),
          backgroundColor: Colors.blue),
      new BottomNavigationBarItem(
          icon: const Icon(Icons.widgets),
          title: new Text(appBarTitles[1]),
          backgroundColor: Colors.blue),
      new BottomNavigationBarItem(
          icon: const Icon(Icons.email),
          title: new Text(appBarTitles[2]),
          backgroundColor: Colors.blue),
    ];
  }

  final navigatorKey = GlobalKey<NavigatorState>();

}

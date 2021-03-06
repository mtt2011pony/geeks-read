import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geeks_read/constant/Constants.dart';
import 'package:geeks_read/http/HttpUtil.dart';
import 'package:geeks_read/item/NewsItem.dart';
import 'package:geeks_read/widget/EndLine.dart';

class ZhNewsPage extends StatefulWidget {
  @override
  ZhNewsPageState createState() => new ZhNewsPageState();
}

class ZhNewsPageState extends State<ZhNewsPage> {
  List listData = new List();
  var curPage = 1;
  var listTotalSize = 0;

  ScrollController _controller = new ScrollController();
  bool isPerformingRequest = false;

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subTitleTextSyle =
      new TextStyle(color: Colors.blue, fontSize: 12.0);

  ZhNewsPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getZhNewsList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getZhNewsList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemCount: listData.length ,
        itemBuilder: (context, i) =>
//        {
//          if (i == listData.length) {
//             _buildProgressIndicator();
//          } else {
        buildItem(i)
//          }
//        }
        ,
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getZhNewsList() {
//    String url = Api.BaseUrl;
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      String url = "?page=$curPage&lang=zh";
      HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;
        var _listData = map['list'];
        listTotalSize = map['count'];
        debugPrint('listTotalSize:$listTotalSize');
        setState(() {
          List list1 = new List();
          if (curPage == 1) {
            listData.clear();
          }
          curPage++;

          list1.addAll(listData);
          list1.addAll(_listData);
          if (list1.length >= listTotalSize) {
            list1.add(Constants.END_LINE_TAG);
          }
          listData = list1;
          isPerformingRequest = false;

        });
      }
      });
    }
  }

  Widget buildItem(int i) {
    var itemData = listData[i];

    if (i == listData.length - 1 && itemData == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new NewsItem(itemData);
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getZhNewsList();
    return null;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}

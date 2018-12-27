import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geeks_read/constant/Constants.dart';
import 'package:geeks_read/http/HttpUtil.dart';
import 'package:geeks_read/item/NewsItem.dart';
import 'package:geeks_read/widget/EndLine.dart';

class EnNewsPage extends StatefulWidget {
  @override
  EnNewsPageState createState() => new EnNewsPageState();
}

class EnNewsPageState extends State<EnNewsPage> {
  int curPage = 1;
  List listData = new List();
  int listTotalSize = 0;
  bool isPerformingRequest = false;

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getNewsList();
    _controller.addListener(() {
      var maxScroll = _controller.position.pixels;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getNewsList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, i) => builItem(i),
        controller: _controller,
        itemCount: listData.length,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getNewsList() {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      String url = "?page=$curPage&lang=en";
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
            isPerformingRequest=false;
          });
        }
      });
    }
  }

  builItem(int i) {
    var itemData = listData[i];
    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }
    return NewsItem(itemData);
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getNewsList();
    return null;
  }
}

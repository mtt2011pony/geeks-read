import 'package:flutter/material.dart';

class NewsListItem extends StatefulWidget {
  var itemData;

  NewsListItem(var itemData) {
    this.itemData = itemData;
  }

  @override
  NewsListItemState createState() => new NewsListItemState();
}

class NewsListItemState extends State<NewsListItem> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('。' + widget.itemData['title'],));
  }
}

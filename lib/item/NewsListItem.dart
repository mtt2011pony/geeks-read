import 'package:flutter/material.dart';
import 'package:geeks_read/pages/NewsDetailPage.dart';

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
        child: new InkWell(child: Text('。' + widget.itemData['title'],),
            onTap: () {
              _itemClick(widget.itemData);
            })
    );
  }

  void _itemClick(news) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new NewsDetailPage(title: news['title'], url: news['url']);
    }));
  }
}

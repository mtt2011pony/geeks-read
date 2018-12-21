import 'package:flutter/material.dart';
import 'package:geeks_read/item/NewsListItem.dart';
import 'package:geeks_read/pages/NewsDetailPage.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatefulWidget {
  var itemData;
  var topic;
  var time;
  bool visible = true;

  List listData = new List();

  NewsItem(var itemData) {
    this.itemData = itemData;
    this.topic = itemData['topic'];
    this.time = topic['date'];
    this.listData = itemData['news'];
  }

  @override
  NewsItemState createState() => new NewsItemState();
}

class NewsItemState extends State<NewsItem> {
  void _handleOpen(itemData) {
    setState(() {
      widget.visible = !widget.visible;
    });
  }

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Row title = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Wrap(
          children: <Widget>[
            new Text.rich(
              new TextSpan(text: widget.topic['title']),
              style: new TextStyle(fontSize: 18.0, color: Colors.black),
              textAlign: TextAlign.left,
            )
          ],
          direction: Axis.horizontal,
        ))
      ],
    );
    Row des = new Row(
      children: <Widget>[
        new Expanded(
            child: new Text.rich(
          new TextSpan(
            text: widget.itemData['summary'],
            style: new TextStyle(fontSize: 14.0, color: Colors.black87,height: 1.2),
          ),
        ))
      ],
    );
    Row bottom = new Row(children: <Widget>[
      new Text(
        widget.topic['source'],
        style: new TextStyle(fontSize: 14.0, color: Colors.black54),
      ),
      new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
          child: new Text(
              DateFormat('yyyyMMdd').format(DateTime.fromMicrosecondsSinceEpoch(
                  widget.time['\$date'] * 1000)),
              style: new TextStyle(fontSize: 14.0, color: Colors.black54))),
      new Expanded(
        child: new Text(
          '共有 ' + (widget.itemData['news_count']).toString() + ' 篇报道',
          style: new TextStyle(fontSize: 14.0, color: Colors.black54),
        ),
      ),
      new GestureDetector(
        child: new Text('点击展开',
            style: new TextStyle(fontSize: 14.0, color: Colors.black54)),
        onTap: () {
          _handleOpen(widget.itemData);
        },
      ),
    ]);
    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 1.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 1.0),
          child: des,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: bottom,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 1.0),
          child: new Wrap(
            children: <Widget>[showList(widget.visible)],
          ),
        )
      ],
    );
    return new Card(
      elevation: 0.6,
      child: new InkWell(
        child: column,
        onTap: () {
          _itemClick(widget.topic);
        },
      ),
    );
  }

  void _itemClick(topic) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new NewsDetailPage(title: topic['title'], url: topic['url']);
    }));
  }

  Widget buildItem(int i) {
    return new NewsListItem(widget.listData[i]);
  }

  Widget showList(bool visible) {
    return new Offstage(
      offstage: widget.visible,
      child: new ListView.builder(
        itemCount: widget.listData.length,
        itemBuilder: (context, i) => buildItem(i),
        controller: _controller,
        shrinkWrap: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  String title;
  String url;

  NewsDetailPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  NewsDetailPageState createState() => new NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage> {
  bool isLoad = true;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: new Text(widget.title),
        bottom: new PreferredSize(
            child: isLoad
                ? new LinearProgressIndicator()
                : new Divider(
                    height: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
            preferredSize: const Size.fromHeight(1.0)),
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
    );
  }
}

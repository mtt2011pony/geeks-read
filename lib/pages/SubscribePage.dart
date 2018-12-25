import 'package:flutter/material.dart';
import 'package:geeks_read/http/Api.dart';
import 'package:geeks_read/http/HttpUtil.dart';
class SubscribePage extends StatefulWidget {
  @override
  SubscribePageState createState() => new SubscribePageState();
}

class SubscribePageState extends State<SubscribePage> {
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Column column = new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Padding(padding: EdgeInsets.all(20.0)),
        new Text(
          '欢迎订阅Geeks Read',
          style: new TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        new Padding(padding: EdgeInsets.all(20.0)),
        new Text(
          '我们会向您的邮箱发送一封验证邮件，您需要点击邮箱中的确认按钮来确认订阅。',
          style: new TextStyle(
            fontSize: 14.0,
          ),
        ),
        new Padding(padding: EdgeInsets.all(20.0)),
        new TextField(
          controller: _controller,
          decoration: new InputDecoration(hintText: '输入邮箱地址'),
        ),
        new Padding(padding: EdgeInsets.all(20.0)),
        new RaisedButton(
            child: new Text(
              '订阅',
              style: new TextStyle(fontSize: 18.0,color: Colors.white),


            ),
            color: Theme.of(context).accentColor,
            splashColor: Colors.blueGrey,
            onPressed: () {
              _subscribe();
            })
      ],
    );
    return new Container(
      child: column,
      padding: EdgeInsets.all(20.0),
    );
  }

  void _subscribe() {
    String email = _controller.text;
    if (email.length == 0) {
      _showMessage('请先输入邮箱');
      return;
    }
    Map<String, String> map = new Map();
    map['email'] = email;
    String url = Api.SUBSCRIBE;
    HttpUtil.post(url, (data) async {
      if (data != null) {
        Map<String, dynamic> map1 = data;
        int result = map1['msg'].toString().compareTo("SUCCESS");
        debugPrint(result.toString());

        if (result == 0) {
          _showMessage('订阅成功');
        } else {
          _showMessage('订阅失败');
        }
      }
    }, params: map,
    );
  }

  void _showMessage(String s) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(s),
    ));
  }


}

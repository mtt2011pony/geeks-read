import 'package:flutter/material.dart';

class SubscribePage extends StatefulWidget {
  @override
  SubscribePageState createState() => new SubscribePageState();
}

class SubscribePageState extends State<SubscribePage> {
  final TextEditingController _controller = new TextEditingController();

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
              showDialog(
                  context: context,
//                  child: new AlertDialog(
//                    title: new Text('确认邮箱'),
//                    content: new Text(_controller.text),
//                  )
              );
            })
      ],
    );
    return new Container(
      child: column,
      padding: EdgeInsets.all(20.0),
    );
  }
}

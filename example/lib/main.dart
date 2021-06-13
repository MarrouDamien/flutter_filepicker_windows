import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _path = '...';
  String _fileName = '...';

  void _openFileExplorer() async {
    try {
      _path = await FilePicker.getFilePath;
    } on PlatformException {
      print('Something went wrong...');
    }

    if (!mounted) return;

    setState(() {
      _fileName = _path.split('/').last;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: new RaisedButton(
                onPressed: () => _openFileExplorer(),
                child: new Text("Open file picker"),
              ),
            ),
            new Text(
              'URI PATH ',
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new Text(
              _path,
              softWrap: true,
              textScaleFactor: 0.85,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Text('FILE NAME ',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
            ),
            new Text(_fileName),
          ],
        )),
      ),
    );
  }
}

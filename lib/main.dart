import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = List<Store>();

  Future fetch() async {
    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

    // 새로고침에 대응하기 위해서 값이 들어있으면 데이터를 지어줌 (값이 계속해서 쌓이는 경우를 방지하기 위함)
    stores.clear();

    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e)); // 모든 데이터가 Store 형식에 맞게 stores에 들어감
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳 : 0곳'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('테스트'),
            onPressed: () async {
              await fetch();
              print(stores.length);
            },
          ),
        ));
  }
}

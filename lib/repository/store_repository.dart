import 'dart:convert';

import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> fetch() async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

    // 상태가 변경이 됐으면 화면에 다시 그려라, 라고 알려주는 것
    //setState(() {
    // 새로고침에 대응하기 위해서 값이 들어있으면 데이터를 지어줌 (값이 계속해서 쌓이는 경우를 방지하기 위함)
    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e)); // 모든 데이터가 Store 형식에 맞게 stores에 들어감
    });
    //   isLoading = false;
    // });

    return stores.where((e) {
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList();
  }
}

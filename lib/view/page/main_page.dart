import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/view/widget/remian_stat_list_tile.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                storeModel.fetch();
              }),
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              /*
        map은 stores 안에 들어있는 Store 데이터들을 변경을 하겠다.
        stores를 e라고 정의 하고, 람다식 뒤에 있는 형식으로 변경을 하겠다. 라는 뜻이다.
        */
              children: storeModel.stores.map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: RemianStatListTile(e),
                );
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

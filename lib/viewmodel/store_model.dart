import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];
  final _storeRepository = StoreRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();
    stores = await _storeRepository.fetch();

    isLoading = false;
    notifyListeners();
  }
}

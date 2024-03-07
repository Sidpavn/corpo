import 'package:corpo/services/player/create_documents.dart';
import 'package:localstorage/localstorage.dart';

LocalStorage storage = LocalStorage('corpo');

Inventory inventoryInfo() {
  Map<String, dynamic> data = {
    "storage": storageInfo(),
  };
  return Inventory.fromJson(data);
}

class Inventory {
  Storage? storage;

  Inventory({
    this.storage,
  });

  Inventory.fromJson(Map<String, dynamic> json) {
    storage = json['storage'];
  }

  Map<String, dynamic> toJson() => {
    "storage": storage,
  };

}

class Storage {
  List<dynamic>? items;

  Storage({
    this.items,
  });

  Storage.fromJson(Map<String, dynamic> json) {
    items = json['items'];
  }

  Map<String, dynamic> toJson() => {
    "items": items,
  };
}
Storage storageInfo() {
  Storage storageData = Storage.fromJson(storage.getItem('storage') ?? fetchStorageDoc());
  return storageData;
}

Map<String,dynamic> storageMap() {
  LocalStorage storage = LocalStorage('corpo');
  Map<String,dynamic> storageData = storage.getItem('storage') ?? fetchStorageDoc();
  return storageData;
}

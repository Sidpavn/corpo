
import 'package:localstorage/localstorage.dart';

LocalStorage storage = LocalStorage("hitman");

deleteItem({required String key}){
  storage.deleteItem(key);
}

setItem({required String key, required dynamic value}){
  storage.setItem(key, value);
}

getItem({required String key}){
  return storage.getItem(key);
}

clearLocalStorage(){
  return storage.clear();
}

enum storageItem {
  tutorialEnabled,
  tutorialCompleted,
  hitmanCards
}
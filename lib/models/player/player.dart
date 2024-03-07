import 'package:localstorage/localstorage.dart';

Player playerInfo() {
  LocalStorage storage = LocalStorage('corpo');
  Player player = Player.fromJson(storage.getItem('player'));
  return player;
}

Map<String,dynamic> playerMap() {
  LocalStorage storage = LocalStorage('corpo');
  Map<String,dynamic> player = storage.getItem('player');
  return player;
}

class Player {
  int? accountLvl;
  int? cash;
  String? deviceId;
  String? username;
  int? xp;
  String? authType;

  Player({this.accountLvl, this.cash, this.deviceId, this.username, this.xp, this.authType});

  Player.fromJson(Map<String, dynamic> json) {
    accountLvl = json['account_lvl'];
    cash = json['cash'];
    deviceId = json['device_id'];
    username = json['username'];
    xp = json['xp'];
    authType = json['auth_type'];
  }

  Map<String, dynamic> toJson() => {
    "account_lvl": accountLvl,
    "cash": cash,
    "device_id": deviceId,
    "username": username,
    "xp": xp,
    "auth_type": authType
  };
}
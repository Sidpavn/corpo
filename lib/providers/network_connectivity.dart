import 'package:flutter/material.dart';

class InternetConnection extends ChangeNotifier {
  bool _connection = false;

  bool get connection => _connection;

  void setconnection(bool value) {
    _connection = value;
    notifyListeners();
  }
}

final internetConnection = InternetConnection();



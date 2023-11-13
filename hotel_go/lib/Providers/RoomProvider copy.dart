import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Adult.dart';

class AdultProvider extends ChangeNotifier {
  List<Adult> _adults = [];

  List<Adult> get adults => _adults;

  void addAdult(Adult adult) {
    _adults.add(adult);
    notifyListeners();
  }

  void removeAdult(Adult) {
    _adults.removeLast();
    notifyListeners();
  }
}

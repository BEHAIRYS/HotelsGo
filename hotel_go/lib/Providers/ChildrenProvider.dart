import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Children.dart';

class ChildrenProvider extends ChangeNotifier {
  List<Children> _children = [];

  List<Children> get children => _children;

  void addChild(Children child) {
    _children.add(child);
    notifyListeners();
  }

  void removeChild(Children child) {
    _children.removeLast();
    notifyListeners();
  }
}

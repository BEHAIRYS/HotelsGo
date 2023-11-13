import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Children.dart';

class ChildrenProvider extends ChangeNotifier {
  Map<String, List<Children>> _childrenByRoom = {};

  Map<String, List<Children>> get childrenByRoom => _childrenByRoom;

  void addChildForRoom(String roomId, Children child) {
    if (!_childrenByRoom.containsKey(roomId)) {
      _childrenByRoom[roomId] = [];
    }

    _childrenByRoom[roomId]!.add(child);
    notifyListeners();
  }

  void removeChildForRoom(String roomId, Children child) {
    if (_childrenByRoom.containsKey(roomId)) {
      _childrenByRoom[roomId]!.remove(child);
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Room.dart';

class RoomProvider extends ChangeNotifier {
  List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  void addRoom(Room room) {
    _rooms.add(room);
    notifyListeners();
  }

  void removeRoom(Room room) {
    _rooms.removeLast();
    notifyListeners();
  }
}

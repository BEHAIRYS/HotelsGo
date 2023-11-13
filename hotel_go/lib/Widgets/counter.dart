import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Children.dart';
import 'package:hotel_go/Data/Room.dart';
import 'package:hotel_go/Providers/ChildrenProvider.dart';
import 'package:hotel_go/Providers/RoomProvider.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  Counter({Key? key, required this.label, required this.type, this.roomId})
      : super(key: key);
  final String label;
  final type;
  String? roomId;
  @override
  State<StatefulWidget> createState() {
    return Counter_state();
  }
}

class Counter_state extends State<Counter> {
  String counterValue() {
    int count = 0;
    if (widget.label == 'Rooms') {
      count = Provider.of<RoomProvider>(context, listen: false).rooms.length;
    }
    if (widget.label == 'Children') {
      Provider.of<ChildrenProvider>(context, listen: false)
          .childrenByRoom
          .forEach((room, children) {
        int length = children.length;
        count = length;
      });
    }
    if (widget.label == 'Adult') {}
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label),
        Row(
          children: [
            IconButton(
              onPressed: _remove,
              icon: const Icon(Icons.remove_circle_outline_sharp),
            ),
            const SizedBox(width: 7),
            Text(counterValue()),
            const SizedBox(width: 7),
            IconButton(
              onPressed: _add,
              icon: const Icon(Icons.add_circle_outline_sharp),
            ),
          ],
        ),
      ],
    );
  }

  void _remove() {
    setState(() {});
    if (widget.label == 'Rooms') {
      Provider.of<RoomProvider>(context, listen: false).removeRoom(widget.type);
    }
    if (widget.label == 'Children') {
      Provider.of<ChildrenProvider>(context, listen: false)
          .removeChildForRoom(widget.roomId!, const Children());
    }
  }

  void _add() {
    setState(() {});
    if (widget.label == 'Rooms') {
      Room room = widget.type;
      Provider.of<RoomProvider>(context, listen: false).addRoom(room);
    }
    if (widget.label == 'Children') {
      Provider.of<ChildrenProvider>(context, listen: false)
          .addChildForRoom(widget.roomId!, const Children());
    }
  }
}

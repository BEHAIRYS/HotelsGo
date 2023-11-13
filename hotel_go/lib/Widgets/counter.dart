import 'package:flutter/material.dart';
import 'package:hotel_go/Providers/RoomProvider.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  Counter({super.key, required this.label, required this.type}) : count = 1;
  final String label;
  int count;
  final type;
  @override
  State<StatefulWidget> createState() {
    return Counter_state();
  }
}

class Counter_state extends State<Counter> {
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
            Text(
              widget.count.toString(),
            ),
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
    setState(() {
      widget.count--;
    });
    if (widget.label == 'Rooms') {
      Provider.of<RoomProvider>(context, listen: false).removeRoom(widget.type);
    }
  }

  void _add() {
    setState(() {
      widget.count++;
    });
    if (widget.label == 'Rooms') {
      Provider.of<RoomProvider>(context, listen: false).addRoom(widget.type);
    }
  }
}

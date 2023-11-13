// Import necessary packages and files

import 'package:flutter/material.dart';
import 'package:hotel_go/Data/Children.dart';
import 'package:hotel_go/Data/Room.dart';
import 'package:hotel_go/Providers/ChildrenProvider.dart';
import 'package:hotel_go/Providers/RoomProvider.dart';
import 'package:hotel_go/Widgets/counter.dart';
import 'package:provider/provider.dart';

class RoomOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RoomOverlayState();
  }
}

class RoomOverlayState extends State<RoomOverlay> {
  List<Room> _rooms = [];
  List<Children> _children = [];

  @override
  void initState() {
    super.initState();
    _rooms.add(const Room());
  }

  final List<TextEditingController> _childAgeControllers = [];

  Widget _childAge() {
    List<Widget> childrenAges = [];

    for (final child in _children) {
      TextEditingController controller = TextEditingController();
      _childAgeControllers.add(controller);
      childrenAges.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Age of child ${_children.indexOf(child)}'),
            Container(
              width: 80,
              height: 40,
              margin: const EdgeInsets.all(7),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: childrenAges,
    );
  }

  @override
  Widget build(BuildContext context) {
    _rooms = Provider.of<RoomProvider>(context).rooms;
    _children = Provider.of<ChildrenProvider>(context).children;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rooms and Guests'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              icon: const Icon(Icons.close_sharp),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child:
                  Counter(label: 'Rooms', type: const Room(), key: UniqueKey()),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Room ${index + 1}'),
                        Counter(
                          label: 'Adults',
                          type: const Room(),
                        ),
                        Counter(
                          label: 'Children',
                          type: const Children(),
                          key: UniqueKey(),
                        ),
                        _childAge(),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

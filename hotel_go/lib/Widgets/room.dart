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
  Map<String, List<Children>> _children = {};
  bool isPetFriendly = false;

  @override
  void initState() {
    super.initState();
    _rooms.add(
      Room(
        id: UniqueKey().toString(),
      ),
    );
  }

  final List<TextEditingController> _childAgeControllers = [];

  Widget _childAge(String id) {
    List<Widget> childrenAges = [];

    for (final MapEntry<String, List<Children>> entry in _children.entries) {
      String roomId = entry.key;
      if (roomId == id) {
        List<Children> childrenList = entry.value;

        for (int i = 0; i < childrenList.length; i++) {
          TextEditingController controller = TextEditingController();
          _childAgeControllers.add(controller);

          childrenAges.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Age of Child ${i + 1}'),
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
            ),
          );
        }
      }
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
    _children = Provider.of<ChildrenProvider>(context).childrenByRoom;
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
              child: Counter(
                  label: 'Rooms',
                  type: Room(id: UniqueKey().toString()),
                  key: UniqueKey()),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _rooms.length + 1, // +1 for the Switch container
              itemBuilder: (context, index) {
                if (index == _rooms.length) {
                  // This is the Switch container
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  Text('Pet Friendly'),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(Icons.info_outline_rounded),
                                ],
                              ),
                              Text('Only show stays that allow pets'),
                            ],
                          ),
                          Switch(
                            value: isPetFriendly,
                            onChanged: (value) {
                              setState(() {
                                isPetFriendly = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // This is the Card container
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Room ${index + 1}'),
                            Counter(
                              label: 'Adults',
                              type: null,
                              key: UniqueKey(),
                            ),
                            Counter(
                              label: 'Children',
                              type: const Children(),
                              key: UniqueKey(),
                              roomId: _rooms[index].id,
                            ),
                            _childAge(_rooms[index].id),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}

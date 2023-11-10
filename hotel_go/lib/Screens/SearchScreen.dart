import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreen_state();
  }
}

class SearchScreen_state extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.hardEdge,
        fit: StackFit.expand,
        children: [
          Image.asset('lib/assets/images/Background.webp',
              fit: BoxFit.cover, alignment: Alignment.topRight),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Text('data'),
          )
        ],
      ),
    );
  }
}

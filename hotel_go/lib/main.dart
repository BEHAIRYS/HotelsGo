import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_go/Providers/ChildrenProvider.dart';
import 'package:hotel_go/Providers/RoomProvider.dart';
import 'package:hotel_go/Screens/SearchScreen.dart';
import 'package:provider/provider.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueAccent,
  brightness: Brightness.light,
);
final theme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: colorScheme,
  cardColor: Colors.white60,
  cardTheme: const CardTheme(
    clipBehavior: Clip.hardEdge,
    shadowColor: Colors.black45,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
      color: colorScheme.onPrimaryContainer,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.blue, // Color of the border
        width: 2.0, // Width of the border
      ),
    ),
  ),
);
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RoomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChildrenProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Hotels Go',
      home: SearchScreen(),
    );
  }
}

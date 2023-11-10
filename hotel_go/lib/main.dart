import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_go/Screens/SearchScreen.dart';

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
);
void main() {
  runApp(const MyApp());
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

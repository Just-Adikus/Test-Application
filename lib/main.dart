import 'package:flutter/material.dart';
import 'features/calendar/presentation/pages/calendar_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Feature',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A90D9)),
      ),
      home: const CalendarPage(),
    );
  }
}

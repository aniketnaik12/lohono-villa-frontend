import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/availability_screen.dart';

class LohonoApp extends StatelessWidget {
  const LohonoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AvailabilityScreen(),
    );
  }
}

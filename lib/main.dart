import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const NusaInfoApp());
}

class NusaInfoApp extends StatelessWidget {
  const NusaInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaInfo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(), // isAdmin: true -> tombol tambah tampil
    );
  }
}
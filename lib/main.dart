import 'package:admin_sistem_akademik/screen/auth/login_page.dart';
import 'package:admin_sistem_akademik/widget/custom_sidebar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Sistem Akademik',
      home: const LoginPage(),
    );
  }
}

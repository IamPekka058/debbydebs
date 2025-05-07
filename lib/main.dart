import 'package:debbydebs/core/theme/app_color.dart';
import 'package:debbydebs/ui/home/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: AppColor.colorScheme),
      home: const HomeView(),
    );
  }
}

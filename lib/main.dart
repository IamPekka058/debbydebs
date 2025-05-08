import 'package:debbydebs/core/theme/app_color.dart';
import 'package:debbydebs/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'core/persistence/database_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHandler().initializeDatabase();
  runApp(const DebbyDebs());
}

class DebbyDebs extends StatelessWidget {
  const DebbyDebs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debby Debs',
      theme: ThemeData.from(colorScheme: AppColor.colorScheme),
      home: const HomeScreen(),
    );
  }
}

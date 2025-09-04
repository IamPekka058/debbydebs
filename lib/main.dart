import "package:debbydebs/core/persistence/app_database.dart";
import "package:debbydebs/core/theme/app_color.dart";
import "package:debbydebs/ui/home/home_screen.dart";
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase();
  runApp(const DebbyDebs());
}

class DebbyDebs extends StatelessWidget {
  const DebbyDebs({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: "Debby Debs",
    theme: ThemeData.from(colorScheme: AppColor.colorScheme),
    home: const HomeScreen(),
  );
}

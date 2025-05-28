import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/persistence/database_handler.dart";
import "package:debbydebs/core/theme/app_color.dart";
import "package:debbydebs/ui/home/home_screen.dart";
import "package:flutter/material.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHandler().initializeDatabase();
  DatabaseHandler().insertContact(Contact(id: 1, name: "Michi"));
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

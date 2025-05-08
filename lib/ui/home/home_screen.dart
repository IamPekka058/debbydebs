import 'package:debbydebs/ui/_widgets/app_bar.dart';
import 'package:debbydebs/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contacts/contacts_view.dart';
import 'home_screen_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: DebbyAppBar(),
            body: switch (viewModel.selectedIndex) {
              0 => HomeView(),
              1 => ContactsView(),
              _ => HomeView(),
            },
            bottomNavigationBar: NavigationBar(
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.inbox),
                  label: "Home",
                ),
                const NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: "Contacts",
                ),
              ],
              onDestinationSelected: (index) => viewModel.updateIndex(index),
              selectedIndex: viewModel.selectedIndex,
            ),
          );
        },
      ),
    );
  }
}

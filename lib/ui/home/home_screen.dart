import "package:debbydebs/ui/_widgets/app_bar.dart";
import "package:debbydebs/ui/contacts/contacts_view.dart";
import "package:debbydebs/ui/home/home_screen_view_model.dart";
import "package:debbydebs/ui/home/home_view.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
      create: (_) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(
        builder: (final context, final viewModel, final child) => Scaffold(
            appBar: const DebbyAppBar(),
            body: switch (viewModel.selectedIndex) {
              0 => const HomeView(),
              1 => const ContactsView(),
              _ => const HomeView(),
            },
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.inbox),
                  label: "Home",
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: "Contacts",
                ),
              ],
              onDestinationSelected: viewModel.updateIndex,
              selectedIndex: viewModel.selectedIndex,
            ),
          ),
      ),
    );
}

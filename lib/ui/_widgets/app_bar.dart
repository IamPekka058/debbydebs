import "package:flutter/material.dart";

class DebbyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DebbyAppBar({super.key});

  @override
  Widget build(final BuildContext context) => AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      title: Text(
        "Debby Debs",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

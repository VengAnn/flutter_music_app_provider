import 'package:flutter/material.dart';
import 'package:music_player/pages/setting_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //logo
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          // home tile
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
            child: ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.of(context).pop(),
            ),
          ),

          // setting tile
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 15.0),
            child: ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                // pop drawer
                Navigator.of(context).pop();

                // Navigation to settings
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

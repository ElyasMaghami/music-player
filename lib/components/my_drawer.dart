import 'package:flutter/material.dart';
import 'package:musicplayer/screens/setting_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //logo

          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note_rounded,
                size: 75,
              ),
            ),
          ),
          //home title
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () {
                return Navigator.pop(context);
              },
            ),
          ),
          //settings title
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: ListTile(
              title: const Text('S E T T I N G S'),
              leading: const Icon(Icons.settings),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

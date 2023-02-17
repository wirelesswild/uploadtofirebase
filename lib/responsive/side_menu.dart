import 'package:flutter/material.dart';
import 'package:uploadtofirebase/components/upload/upload_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 55, 55, 55),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Image.asset(
              '/logo.png',
            ),
          ),
          ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Upload(),
                  ),
                );
              },
              leading: Icon(Icons.dashboard),
              iconColor: Colors.grey,
              title: const Text('Upload'),
              textColor: Colors.grey),

          //data scroll goes here
          //settings here
        ],
      ),
    );
  }
}

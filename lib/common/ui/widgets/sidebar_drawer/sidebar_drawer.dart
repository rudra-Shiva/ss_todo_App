import 'package:flutter/material.dart';
import 'package:todo_app/common/navigation/route_list.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(

              title: const Text('Home'),
              leading: const Icon(Icons.home),
              //contentPadding: EdgeInsets.only(left: 10, right: -10), // Adjust horizontal padding
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, RouteList.mainRoute);

              },
            ),
            ListTile(
              title: const Text('Profile'),
              leading: const Icon(Icons.person),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, RouteList.userProfileView);
              },
            ),ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, RouteList.todoSettingView);
              },
            ),
          ],
        ),
      ),
    );
  }
}

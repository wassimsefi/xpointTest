import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:xpoint/Screens/List.dart';
import 'package:xpoint/Screens/home.dart';
import 'package:xpoint/Screens/notification.dart';
import 'package:xpoint/Screens/profil.dart';

class Menupage extends StatefulWidget {
  const Menupage({Key? key}) : super(key: key);

  @override
  _MenupageState createState() => _MenupageState();
}

class _MenupageState extends State<Menupage> {
  var screens = [
    const Homepage(),
    const Listpage(),
    const Notificationpage(),
    const Profilpage(),
  ]; //screens for each tab

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue[900],
        height: 65,
        backgroundColor: Colors.grey[200],
        index: selectedIndex,
        items: [
          Icon(Icons.home, color: Colors.grey[200]),
          Icon(Icons.list, color: Colors.grey[200]),
          Icon(Icons.notifications, color: Colors.grey[200]),
          Icon(Icons.person, color: Colors.grey[200]),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        animationCurve: Curves.easeInBack,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screens[selectedIndex],
    );
  }
}

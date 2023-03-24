import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';
import 'package:track_one/src/auth/auth_manager.dart';
import 'package:track_one/src/pages/dashboard.dart';
import 'package:track_one/src/pages/users_list.dart';
import 'package:track_one/src/services/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  ///sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [Dashboard(), UsersList()];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leadingWidth: 300,
            leading: Padding(
              padding: const EdgeInsets.only(left: 39.0),
              child: Row(
                children: [
                  Text(
                    "Track",
                    style: TextStyle(
                        color: AppTheme.colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.location_on,
                    color: AppTheme.colors.red,
                  ),
                  Text(
                    "ne",
                    style: TextStyle(
                        color: AppTheme.colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            backgroundColor: AppTheme.colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: signUserOut,
                    child: Icon(
                      Icons.menu,
                      color: AppTheme.colors.black,
                    )),
              )
            ]),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'User List',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppTheme.colors.red.withOpacity(0.8),
          unselectedItemColor: AppTheme.colors.black,
          elevation: 1,
          onTap: _onItemTapped,
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}

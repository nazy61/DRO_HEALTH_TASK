import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'components/home.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2;

  static final List<Widget> _pages = <Widget>[
    Container(),
    Container(),
    const Home(),
    Container(),
    Container(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _pages.elementAt(_selectedIndex),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: AppCustomColors.droPurple,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: AppCustomColors.droAppBottomNavColor,
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account_rounded),
          label: 'Doctors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart),
          label: 'Pharmacy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}

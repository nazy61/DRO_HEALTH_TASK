import 'package:dro_health/cubit/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';
import 'components/home.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static final List<Widget> _pages = <Widget>[
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Doctors"),
    ),
    const Home(),
    const Center(
      child: Text("Community"),
    ),
    const Center(
      child: Text("Profile"),
    ),
  ];

  void _onItemTapped(int index) {
    final navbarCubit = BlocProvider.of<NavbarCubit>(context);
    navbarCubit.changedNavBar(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return _pages.elementAt(state.currentIndex);
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          selectedItemColor: AppCustomColors.droPurple,
          unselectedItemColor: Colors.blueGrey,
          backgroundColor: AppCustomColors.droAppBottomNavColor,
          currentIndex: state.currentIndex, //New
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
      },
    );
  }
}

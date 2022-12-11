import 'package:flutter/material.dart';
import 'package:schedule_app/views/mainScreen/screens/history.dart';
// import 'package:get/get.dart';
import 'package:schedule_app/views/mainScreen/screens/home.dart';
import 'package:schedule_app/views/mainScreen/screens/profile.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({super.key, this.index = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.event_note_outlined),
        activeIcon: Icon(Icons.event_note),
        label: 'Schedule'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        activeIcon: Icon(Icons.account_circle),
        label: 'Profile'),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const ProfileScreen()
  ];

  int _indexPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _indexPage = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.5),
            child: _screens[_indexPage]),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          iconSize: 29,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: Theme.of(context).primaryTextTheme.displaySmall,
          unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          items: _items,
          currentIndex: _indexPage,
          onTap: (value) {
            _indexPage = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quotes/pages/sticky_appbar_list.dart';
import 'package:quotes/pages/sticky_persistent_header_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;
  final _bodySelectedPage = <Widget>[
    const StickyAppBarList(),
    const StickyPersistentHeaderList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _bodySelectedPage,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.groups),
            label: 'by AppBar',
          ),
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'by Persistent Header',
          ),
        ],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}

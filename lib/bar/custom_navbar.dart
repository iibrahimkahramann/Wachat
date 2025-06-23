import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentLocation,
  });

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings'.tr(),
        ),
      ],
      currentIndex: _calculateSelectedIndex(currentLocation),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (index) => _onItemTapped(index, context),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/settings')) return 1;

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/settings');
        break;
    }
  }
}

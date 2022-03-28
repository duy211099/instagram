import 'package:flutter/material.dart';
import 'package:flutter_instagram/enums/bottom_nav_item.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar(
      {Key? key,
      required this.items,
      required this.selectedItem,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items
          .map((key, value) => MapEntry(key.toString(),
              BottomNavigationBarItem(label: '', icon: Icon(value, size: 30))))
          .values
          .toList(),
    );
  }
}

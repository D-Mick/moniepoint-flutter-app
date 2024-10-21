import 'package:flutter/material.dart';

typedef BottomNavItem = ({int index, IconData icon});

typedef MenuItem = ({int index, IconData icon, String title});

typedef ListingModel = ({
  String address,
  String image,
  int mainAxis,
  int crossAxis
});

class Constants {
  static List<BottomNavItem> navItems = [
    (index: 0, icon: Icons.search_outlined),
    (index: 1, icon: Icons.message_outlined),
    (index: 2, icon: Icons.home_outlined),
    (index: 3, icon: Icons.favorite_border_outlined),
    (index: 4, icon: Icons.person_outline_rounded),
  ];

  static List<MenuItem> menuItems = [
    (index: 0, icon: Icons.check_circle_outlined, title: 'Cosy areas'),
    (index: 1, icon: Icons.account_balance_wallet_outlined, title: 'Price'),
    (index: 2, icon: Icons.factory_outlined, title: 'Infrastructure'),
    (index: 3, icon: Icons.layers, title: 'Without any layer'),
  ];

  static List<ListingModel> listings = [
    (
      address: 'Gladkova St., 25',
      image: 'assets/images/default_image_one.jpg',
      mainAxis: 2,
      crossAxis: 1
    ),
    (
      address: 'Gubina St., 11',
      image: 'assets/images/default_image_two.jpg',
      mainAxis: 1,
      crossAxis: 2
    ),
    (
      address: 'Trefoleva St., 43',
      image: 'assets/images/default_image_one.jpg',
      mainAxis: 1,
      crossAxis: 1
    ),
    (
      address: 'Sedova St., 22',
      image: 'assets/images/default_image_two.jpg',
      mainAxis: 1,
      crossAxis: 1
    )
  ];
}

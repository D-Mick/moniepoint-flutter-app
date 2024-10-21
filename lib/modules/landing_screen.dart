import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/config/app_constants.dart';
import 'package:moniepointflutterapp/modules/home/home_screen.dart';
import 'package:moniepointflutterapp/modules/search/search_screen.dart';
import 'package:moniepointflutterapp/shared/widgets/bottom_nav/bottom_nav_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late PageController _controller;
  int _screenIndex = 2;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _screenIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: Constants.navItems.map<Widget>((item) {
              if (item.index == 2) {
                return const HomeScreen();
              } else if (item.index == 0) {
                return const SearchLocationScreen();
              } else {
                return Center(child: Icon(item.icon));
              }
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: BottomNavBar(
                currentScreen: _screenIndex,
                controller: _controller,
                onScreenChanged: (index) {
                  setState(() {
                    _screenIndex = index;
                  });
                }),
          )
        ],
      ),
    );
  }
}

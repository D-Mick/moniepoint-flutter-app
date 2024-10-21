import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/config/app_constants.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {super.key,
      required this.currentScreen,
      required this.controller,
      required this.onScreenChanged});

  final int currentScreen;
  final PageController controller;
  final void Function(int index) onScreenChanged;

  @override
  State<StatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool _navBarAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 4800));
      setState(() {
        _navBarAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
        offset: _navBarAnimation ? Offset.zero : const Offset(0, 1),
        duration: const Duration(milliseconds: 500),
        child: SafeArea(
          child: Material(
            shape: const StadiumBorder(),
            color: lightTheme.colorScheme.shadow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: Constants.navItems.map((item) {
                final selected = item.index == widget.currentScreen;
                return GestureDetector(
                  onTap: () {
                    widget.onScreenChanged.call(item.index);
                    widget.controller.jumpToPage(item.index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundColor:
                          selected ? lightTheme.colorScheme.primary : lightTheme.colorScheme.surface,
                      radius: selected ? 24 : 20,
                      child: Icon(
                        item.icon,
                        color: lightTheme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}

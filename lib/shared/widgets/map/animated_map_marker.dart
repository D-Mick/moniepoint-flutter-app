import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

class CustomMapMarker extends StatefulWidget {

  final String title;
  const CustomMapMarker({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _CustomMapMarkerState();
}

class _CustomMapMarkerState extends State<CustomMapMarker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: lightTheme.colorScheme.primary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(42),
              topRight: Radius.circular(42),
              bottomRight: Radius.circular(42))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Text(
          widget.title,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

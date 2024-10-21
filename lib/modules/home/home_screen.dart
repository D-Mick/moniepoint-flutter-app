import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/modules/home/widgets/home_body.dart';
import 'package:moniepointflutterapp/modules/home/widgets/places.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [lightTheme.colorScheme.onPrimary, lightTheme.colorScheme.scrim],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.1, 0.9])),
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext headerContext, bool boolean) {
            return [
              const SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 450,
                flexibleSpace: FlexibleSpaceBar(
                  background: HomePageBody(),
                ),
              )
            ];
          },
          body: const Places()),
    );
  }
}

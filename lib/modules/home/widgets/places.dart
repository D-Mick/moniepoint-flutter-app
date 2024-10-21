import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moniepointflutterapp/config/app_constants.dart';
import 'package:moniepointflutterapp/shared/widgets/containers/listing_item.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

class Places extends StatefulWidget {
  const Places({
    super.key,
  });

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  bool _animateListings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 3500));
      if (mounted) {
        setState(() {
          _animateListings = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
        offset: _animateListings ? Offset.zero : const Offset(0, 1),
        duration: const Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            color: lightTheme.colorScheme.onPrimary,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: Constants.listings
                        .map(
                          (listing) => StaggeredGridTile.count(
                            crossAxisCellCount: listing.mainAxis,
                            mainAxisCellCount: listing.crossAxis,
                            child: PlacesItem(
                              image: listing.image,
                              address: listing.address,
                              alignment: listing.mainAxis > listing.crossAxis
                                  ? Alignment.center
                                  : Alignment.centerLeft,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

/// A widget that displays a title, an animated count, and a label ('offers'),
/// with configurable shape, color, and border radius.
class OfferWidget extends StatefulWidget {
  const OfferWidget({
    super.key,
    required this.title,  // The title to display.
    required this.count,  // The count to animate to.
    this.shape,           // Optional: Shape of the widget (rectangle or circle).
    this.borderRadius,    // Optional: Border radius for custom shapes.
    this.color,           // Optional: Background color.
    this.textColor,       // Optional: Text color.
  });

  final String title;
  final String count;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? textColor;

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController; // Controls the animation timeline.
  late Animation<int> _animateCount; // Animates the count from 0 to the provided value.

  bool _animateSize = false; // Tracks whether the widget has grown to full size.

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 1.2 seconds.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Create an integer animation from 0 to the parsed value of `count`.
    _animateCount = StepTween(
      begin: 0,
      end: int.parse(widget.count.trim()),  // Ensures the count is properly parsed.
    ).animate(_animationController);

    // Trigger animations with a delay after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 3000)); // 3-second delay.
      if (mounted) {
        setState(() {
          _animateSize = true;  // Enable widget size animation.
        });
        _animationController.forward();  // Start the count animation.
      }
    });
  }

  @override
  void dispose() {
    // Dispose the animation controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 500),
      scale: _animateSize ? 1 : 0,  // Scale from 0 to 1 for entry animation.
      child: Container(
        width: double.maxFinite,  // Takes the full available width.
        padding: const EdgeInsets.all(20),  // Add padding inside the container.
        decoration: BoxDecoration(
          shape: widget.shape ?? BoxShape.rectangle,  // Default to rectangle.
          color: widget.color ?? lightTheme.colorScheme.primary,  // Set background color.
          borderRadius: widget.borderRadius,  // Custom border radius if provided.
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Wraps the content tightly.
            children: [
              // Display the title text.
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.textColor ?? lightTheme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 24),  // Spacing between title and count.

              // Animated count display using `AnimatedBuilder`.
              AnimatedBuilder(
                animation: _animateCount,
                builder: (context, child) {
                  return FittedBox(
                    child: Text(
                      '${_animateCount.value}',  // Display the current animation value.
                      style: TextStyle(
                        fontSize: 40,  // Large font size for count.
                        fontWeight: FontWeight.bold,  // Bold to emphasize count.
                        color: widget.textColor ?? lightTheme.colorScheme.onPrimary,
                      ),
                    ),
                  );
                },
              ),

              // Display the 'offers' label below the count.
              Text(
                'offers',
                style: TextStyle(
                  color: widget.textColor ?? lightTheme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

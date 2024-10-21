import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';

class SlidingButton extends StatefulWidget {
  const SlidingButton({
    super.key,
    required this.label,
    required this.alignment,
  });

  final String label;
  final AlignmentGeometry alignment;

  @override
  State<SlidingButton> createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  bool _isButtonExpanded = false;
  bool _isLabelVisible = false;

  @override
  void initState() {
    super.initState();
    _triggerAnimations();
  }

  /// Triggers sequential animations with delays to expand the button
  /// and show the label.
  void _triggerAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final randomDelay = Random().nextInt(1000) + 3700;

      // Wait for the random delay before starting the button expansion animation.
      await Future.delayed(Duration(milliseconds: randomDelay));
      if (mounted) {
        setState(() => _isButtonExpanded = true);
      }

      // Small delay before making the label visible.
      await Future.delayed(const Duration(milliseconds: 400));
      if (mounted) {
        setState(() => _isLabelVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 40,
          width: _isButtonExpanded ? constraints.maxWidth : 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: lightTheme.colorScheme.secondary.withOpacity(0.3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Stack(
                children: [
                  // Label aligned based on the given alignment.
                  _buildAnimatedLabel(),

                  // Circular icon that moves based on button expansion state.
                  _buildAnimatedIcon(constraints),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the animated label that becomes visible after a delay.
  Widget _buildAnimatedLabel() {
    return Align(
      alignment: widget.alignment,
      child: AnimatedOpacity(
        opacity: _isLabelVisible ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(widget.label),
        ),
      ),
    );
  }

  /// Builds the animated icon that moves from left to right.
  Widget _buildAnimatedIcon(BoxConstraints constraints) {
    return AnimatedPositioned(
      right: _isButtonExpanded ? 0 : constraints.maxWidth - 40,
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.only(right: 1, top: 2),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: lightTheme.colorScheme.onPrimary,
          child: Icon(
            Icons.keyboard_arrow_right_sharp,
            color: lightTheme.colorScheme.surface,
            size: 16,
          ),
        ),
      ),
    );
  }
}

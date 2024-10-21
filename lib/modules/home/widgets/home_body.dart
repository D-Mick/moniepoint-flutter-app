import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/shared/res/themes/light.dart';
import 'package:moniepointflutterapp/shared/widgets/containers/offer_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  // Animation state variables for controlling individual elements.
  bool _isLocationVisible = false;
  bool _isAvatarVisible = false;
  bool _isGreetingVisible = false;
  bool _isLine1Visible = false;
  bool _isLine2Visible = false;

  @override
  void initState() {
    super.initState();
    _triggerAnimations(); // Start the animation sequence on widget initialization.
  }

  /// Triggers a sequential animation with delays between each step.
  void _triggerAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _animateStep(() => _isAvatarVisible = true, delay: 200);
      await _animateStep(() => _isLocationVisible = true, delay: 500);
      await _animateStep(() => _isGreetingVisible = true, delay: 700);
      await _animateStep(() => _isLine1Visible = true, delay: 900);
      await _animateStep(() => _isLine2Visible = true, delay: 100);
    });
  }

  /// Executes an animation step after a delay if the widget is still mounted.
  Future<void> _animateStep(VoidCallback action, {int delay = 200}) async {
    await Future.delayed(Duration(milliseconds: delay));
    if (mounted) {
      setState(action);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        children: [
          _buildHeader(), // Top bar with location and avatar.
          const SizedBox(height: 10),
          _buildGreetingText(), // Animated greeting text.
          const SizedBox(height: 10),
          _buildAnimatedTextLine("Let's select your", _isLine1Visible), // First animated line.
          _buildAnimatedTextLine('Perfect place', _isLine2Visible), // Second animated line.
          const SizedBox(height: 36),
          _buildOfferItems(), // Row with 'BUY' and 'RENT' offer items.
        ],
      ),
    );
  }

  /// Builds the top bar containing the animated location and avatar widgets.
  Widget _buildHeader() {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLocationWidget(), // Animated location container.
          _buildAvatarWidget(),   // Animated avatar widget.
        ],
      ),
    );
  }

  /// Creates an animated container displaying the user's location.
  Widget _buildLocationWidget() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _isLocationVisible ? 1 : 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: lightTheme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: lightTheme.colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            Text(
              'Saint Petersburg',
              style: TextStyle(
                color: lightTheme.colorScheme.secondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates an animated circular avatar using a gradient background.
  Widget _buildAvatarWidget() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 500),
      scale: _isAvatarVisible ? 1 : 0,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.6],
            colors: [
              lightTheme.colorScheme.tertiary,
              lightTheme.colorScheme.primary,
            ],
          ),
        ),
        child: Image.asset('assets/images/avatar_image.png'),
      ),
    );
  }

  /// Creates the animated greeting text.
  Widget _buildGreetingText() {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isGreetingVisible ? 1 : 0,
        child: Text(
          'Hi, Marina',
          style: TextStyle(color: lightTheme.colorScheme.secondary),
        ),
      ),
    );
  }

  /// Creates a line of animated text.
  Widget _buildAnimatedTextLine(String text, bool isVisible) {
    return ClipRRect(
      child: Align(
        alignment: Alignment.topLeft,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          offset: isVisible ? Offset.zero : const Offset(0, 1),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 36,
              color: lightTheme.colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a row of offer items ('BUY' and 'RENT').
  Widget _buildOfferItems() {
    return Row(
      children: [
        const Expanded(
          child: OfferWidget(
            title: 'BUY',
            count: "1034",
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: OfferWidget(
            title: 'RENT',
            count: "2212",
            color: lightTheme.colorScheme.onPrimary,
            textColor: lightTheme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}

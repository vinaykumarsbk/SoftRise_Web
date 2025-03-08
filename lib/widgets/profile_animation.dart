import 'package:flutter/material.dart'; // Font Awesome icons
import 'package:soft_rise/constants.dart';
import 'package:soft_rise/globals/app_assets.dart';
import 'package:soft_rise/globals/utility.dart';

class ProfileAnimation extends StatefulWidget {
  final double profilePictureWidth;
  final double profilePictureHeight;
  final double backgroundWidth;
  final double backgroundHeight;
  final double containerWidth;
  final double containerHeight;
  final double socialIconsWidth;
  final double socialIconsHeight;

  const ProfileAnimation({
    required this.profilePictureWidth,
    required this.profilePictureHeight,
    required this.backgroundWidth,
    required this.backgroundHeight,
    required this.socialIconsWidth,
    required this.socialIconsHeight,
    required this.containerWidth,
    required this.containerHeight,
    super.key,
  });

  @override
  _ProfileAnimationState createState() => _ProfileAnimationState();
}

class _ProfileAnimationState extends State<ProfileAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _animation = Tween(begin: const Offset(0, 0.05), end: const Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Background Container
        SizedBox(
          height: widget.backgroundHeight,
          width: widget.backgroundWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: widget.containerWidth,
                height: widget.containerHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.grey[100],
                ),
              ),
            ],
          ),
        ),

        // Profile Picture with Animation
        Positioned(
          left: 40.0,
          bottom: 40.0,
          child: SlideTransition(
            position: _animation,
            child: Container(
              width: widget.profilePictureWidth,
              height: widget.profilePictureHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Theme.of(context).canvasColor,
              ),
              child: Image.asset(AppAssets.profile1),
            ),
          ),
        ),

        // Social Media Icons
        Positioned(
          right: 40.0,
          bottom: 50.0,
          child: SizedBox(
            height: widget.socialIconsHeight,
            width: widget.socialIconsWidth,
            child: GridView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Constants.social.length,
              itemBuilder: (BuildContext context, int index) {
                Map socialItem = Constants.social[index];
                return MouseRegion(
                  onEnter: (_) {},
                  child: IconButton(
                    onPressed: () => Utility.launchURL(socialItem['link']),
                    icon: Icon(
                      socialItem['icon'],
                      size: 45.0,
                      color: Color(0xff414141),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

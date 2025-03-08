import 'package:flutter/material.dart';

class HelperClass extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double paddingWidth;
  final Color bgColor;
  final Color bgColor1;
  final Color bgColor2;
  const HelperClass({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.paddingWidth,
    required this.bgColor,
    required this.bgColor1,
    required this.bgColor2
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return Container(
            // height: size.height,
            width: size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bgColor,
                  bgColor1,
                  bgColor2
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0, 0.0],
                tileMode: TileMode.clamp,
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.05, horizontal: 18),
            child: mobile,
          );
        } else if (constraints.maxWidth < 1200) {
          return Container(
            // height: size.height,
            width: size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bgColor,
                  bgColor1,
                  bgColor2
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0, 0.0],
                tileMode: TileMode.clamp,
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.1, horizontal: paddingWidth),
            child: tablet,
          );
        } else {
          return Container(
            // height: size.height,
            width: size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  bgColor,
                  bgColor1,
                  bgColor2
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: const [0.0, 1.0, 0.0],
                tileMode: TileMode.clamp,
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.18, horizontal: paddingWidth),
            child: desktop,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';

class FirstClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    path.lineTo(-36.5944 * xScaling, 16.2899 * yScaling);
    path.cubicTo(
      -163.713 * xScaling,
      -6.31618 * yScaling,
      -295 * xScaling,
      659.969 * yScaling,
      -295 * xScaling,
      220.935 * yScaling,
    );
    path.cubicTo(
      -295 * xScaling,
      -218.1 * yScaling,
      -295 * xScaling,
      -106.259 * yScaling,
      -295 * xScaling,
      -106.259 * yScaling,
    );
    path.cubicTo(
      -295 * xScaling,
      -106.259 * yScaling,
      450 * xScaling,
      -106.259 * yScaling,
      450 * xScaling,
      -106.259 * yScaling,
    );
    path.cubicTo(
      450 * xScaling,
      -106.259 * yScaling,
      368.727 * xScaling,
      154.306 * yScaling,
      236.399 * xScaling,
      187.62 * yScaling,
    );
    path.cubicTo(
      104.07 * xScaling,
      220.935 * yScaling,
      90.5244 * xScaling,
      38.896 * yScaling,
      -36.5944 * xScaling,
      16.2899 * yScaling,
    );
    path.cubicTo(
      -36.5944 * xScaling,
      16.2899 * yScaling,
      -36.5944 * xScaling,
      16.2899 * yScaling,
      -36.5944 * xScaling,
      16.2899 * yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SecondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    final offset = size.height * 0.4;
    path.moveTo(0, 100);
    path.lineTo(0.353281 * xScaling, 123.365 * yScaling + offset);
    path.cubicTo(
      0.353281 * xScaling,
      123.365 * yScaling + offset,
      30.9078 * xScaling,
      197.16 * yScaling + offset,
      147.965 * xScaling,
      122.935 * yScaling + offset,
    );
    path.cubicTo(
      265.021 * xScaling,
      48.7098 * yScaling + offset,
      430.351 * xScaling,
      122.111 * yScaling + offset,
      430.351 * xScaling,
      122.111 * yScaling + offset,
    );
    path.cubicTo(
      430.351 * xScaling,
      122.111 * yScaling + offset,
      429.998 * xScaling,
      0.99998 * yScaling + offset,
      429.998 * xScaling,
      0.99998 * yScaling + offset,
    );
    path.cubicTo(
      429.998 * xScaling,
      0.99998 * yScaling + offset,
      0.0000430825 * xScaling,
      2.25413 * yScaling + offset,
      0.0000430825 * xScaling,
      2.25413 * yScaling + offset,
    );
    path.cubicTo(
      0.0000430825 * xScaling,
      2.25413 * yScaling + offset,
      0.353281 * xScaling,
      123.365 * yScaling + offset,
      0.353281 * xScaling,
      123.365 * yScaling + offset,
    );
    path.cubicTo(
      0.353281 * xScaling,
      123.365 * yScaling + offset,
      0.353281 * xScaling,
      123.365 * yScaling + offset,
      0.353281 * xScaling,
      123.365 * yScaling + offset,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ThirdClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double xScaling = size.width / 414;
    final double yScaling = size.height / 896;
    final double offset = size.height * 0.9;
    path.moveTo(0, offset);
    path.lineTo(0.0000305176 * xScaling, 28.5155 * yScaling + offset);
    path.cubicTo(
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
      30.3392 * xScaling,
      -33.3944 * yScaling + offset,
      147.612 * xScaling,
      28.5155 * yScaling + offset,
    );
    path.cubicTo(
      264.885 * xScaling,
      90.4253 * yScaling + offset,
      430 * xScaling,
      28.5155 * yScaling + offset,
      430 * xScaling,
      28.5155 * yScaling + offset,
    );
    path.cubicTo(
      430 * xScaling,
      28.5155 * yScaling + offset,
      430 * xScaling,
      130 * yScaling + offset,
      430 * xScaling,
      130 * yScaling + offset,
    );
    path.cubicTo(
      430 * xScaling,
      130 * yScaling + offset,
      0.0000305176 * xScaling,
      130 * yScaling + offset,
      0.0000305176 * xScaling,
      130 * yScaling + offset,
    );
    path.cubicTo(
      0.0000305176 * xScaling,
      130 * yScaling + offset,
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
    );
    path.cubicTo(
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
      0.0000305176 * xScaling,
      28.5155 * yScaling + offset,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

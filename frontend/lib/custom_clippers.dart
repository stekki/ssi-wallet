import 'package:flutter/material.dart';

class FirstClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(-36.5944 * _xScaling, 16.2899 * _yScaling);
    path.cubicTo(
      -163.713 * _xScaling,
      -6.31618 * _yScaling,
      -295 * _xScaling,
      659.969 * _yScaling,
      -295 * _xScaling,
      220.935 * _yScaling,
    );
    path.cubicTo(
      -295 * _xScaling,
      -218.1 * _yScaling,
      -295 * _xScaling,
      -106.259 * _yScaling,
      -295 * _xScaling,
      -106.259 * _yScaling,
    );
    path.cubicTo(
      -295 * _xScaling,
      -106.259 * _yScaling,
      450 * _xScaling,
      -106.259 * _yScaling,
      450 * _xScaling,
      -106.259 * _yScaling,
    );
    path.cubicTo(
      450 * _xScaling,
      -106.259 * _yScaling,
      368.727 * _xScaling,
      154.306 * _yScaling,
      236.399 * _xScaling,
      187.62 * _yScaling,
    );
    path.cubicTo(
      104.07 * _xScaling,
      220.935 * _yScaling,
      90.5244 * _xScaling,
      38.896 * _yScaling,
      -36.5944 * _xScaling,
      16.2899 * _yScaling,
    );
    path.cubicTo(
      -36.5944 * _xScaling,
      16.2899 * _yScaling,
      -36.5944 * _xScaling,
      16.2899 * _yScaling,
      -36.5944 * _xScaling,
      16.2899 * _yScaling,
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
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    final offset = size.height * 0.4;
    path.moveTo(0, 100);
    path.lineTo(0.353281 * _xScaling, 123.365 * _yScaling + offset);
    path.cubicTo(
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
      30.9078 * _xScaling,
      197.16 * _yScaling + offset,
      147.965 * _xScaling,
      122.935 * _yScaling + offset,
    );
    path.cubicTo(
      265.021 * _xScaling,
      48.7098 * _yScaling + offset,
      430.351 * _xScaling,
      122.111 * _yScaling + offset,
      430.351 * _xScaling,
      122.111 * _yScaling + offset,
    );
    path.cubicTo(
      430.351 * _xScaling,
      122.111 * _yScaling + offset,
      429.998 * _xScaling,
      0.99998 * _yScaling + offset,
      429.998 * _xScaling,
      0.99998 * _yScaling + offset,
    );
    path.cubicTo(
      429.998 * _xScaling,
      0.99998 * _yScaling + offset,
      0.0000430825 * _xScaling,
      2.25413 * _yScaling + offset,
      0.0000430825 * _xScaling,
      2.25413 * _yScaling + offset,
    );
    path.cubicTo(
      0.0000430825 * _xScaling,
      2.25413 * _yScaling + offset,
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
    );
    path.cubicTo(
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
      0.353281 * _xScaling,
      123.365 * _yScaling + offset,
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
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    final double offset = size.height * 0.9;
    path.moveTo(0, offset);
    path.lineTo(0.0000305176 * _xScaling, 28.5155 * _yScaling + offset);
    path.cubicTo(
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
      30.3392 * _xScaling,
      -33.3944 * _yScaling + offset,
      147.612 * _xScaling,
      28.5155 * _yScaling + offset,
    );
    path.cubicTo(
      264.885 * _xScaling,
      90.4253 * _yScaling + offset,
      430 * _xScaling,
      28.5155 * _yScaling + offset,
      430 * _xScaling,
      28.5155 * _yScaling + offset,
    );
    path.cubicTo(
      430 * _xScaling,
      28.5155 * _yScaling + offset,
      430 * _xScaling,
      130 * _yScaling + offset,
      430 * _xScaling,
      130 * _yScaling + offset,
    );
    path.cubicTo(
      430 * _xScaling,
      130 * _yScaling + offset,
      0.0000305176 * _xScaling,
      130 * _yScaling + offset,
      0.0000305176 * _xScaling,
      130 * _yScaling + offset,
    );
    path.cubicTo(
      0.0000305176 * _xScaling,
      130 * _yScaling + offset,
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
    );
    path.cubicTo(
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
      0.0000305176 * _xScaling,
      28.5155 * _yScaling + offset,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

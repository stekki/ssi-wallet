import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/utils/styles.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: scaffoldBackground,
        child: Center(
          child: SpinKitFadingCircle(
            size: height * 0.23,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven
                      ? DesignColors.extraColorWhite
                      : DesignColors.extraColorGray,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

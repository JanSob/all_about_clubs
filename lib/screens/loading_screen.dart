import 'package:all_about_clubs/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, //Color(0xFFE5E5E5), //lawLingualDarkBlue,
      child: const SpinKitChasingDots(
        color: THEME_COLOR,
        size: 120.0,
      ),
    );
  }
}

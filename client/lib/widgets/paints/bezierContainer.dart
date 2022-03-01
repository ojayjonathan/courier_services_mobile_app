import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BezierContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset("assets/images/rp.svg"),
    );
  }
}

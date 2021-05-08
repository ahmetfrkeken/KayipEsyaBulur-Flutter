import 'package:flutter/material.dart';

import 'OnBoardButtonClipper.dart';

    class button extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return ClipPath(
    clipper: OnBoardButtonClipper(),
    child:Container(
    width: 90,
    height: 90,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color(0xffd32f2f),
    Color(0xffef5350),
    ],
    stops: [
    0.4,
    0.1,
    ],
    ),
    ),
    child: Center(
    child: Padding(
    padding: EdgeInsets.only(left: 45),
    child: Icon(
    Icons.arrow_forward_ios,
    color: Colors.white,
    ),
    ),
    ),
    )
    );
  }
}

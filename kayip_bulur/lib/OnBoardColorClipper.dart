import 'package:flutter/material.dart';

class OnBoardColorClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(12, size.height-38, 40, size.height-48);
    path.lineTo(size.width-40, size.height-140);
    path.quadraticBezierTo(size.width, size.height-145, size.width, size.height-200);
    path.lineTo(size.width, 0);
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
import 'package:flutter/material.dart';

class OnBoardButtonClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();



    path.moveTo(0, size.height/2);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width-50, 0, 0 , size.height/2);
    path.moveTo(size.width, size.height);
    path.quadraticBezierTo(size.width-50, size.height, 0 , size.height/2);



    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}
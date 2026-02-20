
import 'package:flutter/rendering.dart';

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height - 10);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25 , size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, 
    firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 20);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, 
    secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopWaveClipper extends CustomClipper<Path>{


  @override
  Path getClip(Size size){
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4 , size.height );
    var firstEndPoint = Offset(size.width / 2.1 , size.height - 45);

    path.quadraticBezierTo(
      firstControlPoint.dx, 
      firstControlPoint.dy, 
      firstEndPoint.dx, 
      firstEndPoint.dy
    );

    var secondControlPoint = Offset(
      size.width * 0.75 , 
      size.height - 90);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(
      secondControlPoint.dx, 
      secondControlPoint.dy, 
      secondEndPoint.dx, 
      secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
import 'package:flutter/material.dart';

class ControllerBottomBar extends StatelessWidget {
  const ControllerBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox.fromSize(
              size: const Size.fromHeight(80.0),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size.fromHeight(80),
                    painter: BottomCustomPainter(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      height: double.infinity,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.gps_fixed, color: Colors.white, size: 32,),
                          Icon(Icons.list, color: Colors.white, size: 32,)
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomPaint(
                      painter: AddCustomPainter(),
                      child: Center(
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          child: const Icon(Icons.add, color: Colors.indigo,)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    Paint paint = Paint()..color = Colors.indigo.shade800..style = PaintingStyle.fill;
    Path path = Path()..moveTo(width * 0.2, height);

    path.quadraticBezierTo(width * 0.3, height, width * 0.3, height * 0.55);
    path.quadraticBezierTo(width * 0.3, 0.0, width * 0.4, 0.1);
    path.quadraticBezierTo(width * 0.5, 0.0, width * 0.6, 0.1);
    path.quadraticBezierTo(width * 0.7, 0.0, width * 0.7, height * 0.55);
    path.quadraticBezierTo(width * 0.7, height, width * 0.8, height);

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();

    // canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }  
}

class BottomCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.3)..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0.0, 0.0);

    double width = size.width;
    double height = size.height;

    path.quadraticBezierTo(width * 0.5, height * 0.5, width, 0.0);

    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();

    // canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }  
}
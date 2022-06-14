import 'package:flutter/material.dart';

class TesteLayout extends StatefulWidget {
  const TesteLayout({Key? key}) : super(key: key);

  @override
  State<TesteLayout> createState() => _TesteLayoutState();
}

class _TesteLayoutState extends State<TesteLayout>
    with SingleTickerProviderStateMixin {
  final double maxSlide = 225.0;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  void _onDragStart(DragStartDetails details) {
    //bool isDragOpenFromLeft =
    //animationController.isDismissed && details.globalPosition.dx < minDragStartEdge;
  }
  void _onDragUpdate(DragUpdateDetails details) {
    //bool isDragOpenFromLeft =
    //animationController.isDismissed && details.globalPosition.dx < minDragStartEdge;
  }
  void _onDragEnd(DragEndDetails details) {
    //bool isDragOpenFromLeft =
    //animationController.isDismissed && details.globalPosition.dx < minDragStartEdge;
  }

  @override
  Widget build(BuildContext context) {
    var myDrawer = Container(
      color: Colors.blue,
    );

    var myChild = Container(
      color: Colors.yellow,
    );

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          double slide = maxSlide * animationController.value;
          double scale = 1 - (animationController.value * 0.3);
          return Stack(
            children: <Widget>[
              myDrawer,
              Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: myChild)
            ],
          );
        },
      ),
    );
  }
}

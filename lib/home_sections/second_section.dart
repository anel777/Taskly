import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Taskly/notes.dart';
import 'package:Taskly/task.dart';

class HomeSecondSection extends StatelessWidget {
  const HomeSecondSection({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: _screenHeight * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute(Task()));
            },
            child: Container(
              //Task
              height: _screenHeight * .09,
              width: _screenHeight * .09,
              decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(_screenHeight * 0.025)),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(_createRoute(Notes()));
            },
            child: Container(
              height: _screenHeight * .09,
              width: _screenHeight * .09,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(_screenHeight * 0.025)),
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.decelerate;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

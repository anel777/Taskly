import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn/task.dart';

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Task(),
                  ));
            },
            child: Container(
              //Task
              height: _screenHeight * .09,
              width: _screenHeight * .09,
              decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Container(
            height: _screenHeight * .09,
            width: _screenHeight * .09,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(20)),
          ),
          Container(
            height: _screenHeight * .09,
            width: _screenHeight * .09,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}

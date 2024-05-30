import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:Taskly/main.dart';
import 'package:Taskly/task.dart';
import 'package:provider/provider.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Consumer<TaskProvider>(
      builder: (context, value, _) {
        return SizedBox(
          height: 0.3 * _screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TASKLY',
                      style: TextStyle(
                          fontSize: _screenWidth * .14,
                          letterSpacing: _screenHeight * .008,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.task_alt)
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: _screenHeight * .35,
                  height: _screenHeight * .004,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Task Remaining  : ${value.taskCount()}',
                      style: TextStyle(letterSpacing: 5),
                    ),
                    Container(
                      width: _screenWidth * .007,
                      height: _screenWidth * .05,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Text(
                      '${value.taskCompleted}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Center(
                  child: Text(
                'Task Ratio : ${value.taskCompleted} / ${value.taskCompleted + value.taskCount()}',
                style: TextStyle(letterSpacing: 4),
              )),
              Center(
                child: Container(
                  width: _screenHeight * .35,
                  height: _screenHeight * .004,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Taskly/main.dart';
import 'package:provider/provider.dart';

class HomeThirdSection extends StatelessWidget {
  const HomeThirdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, _) {
        if (value.taskCount() == 0) {
          return EmptyListHome();
        } else
          return TaskListHome();
      },
    );
  }
}

class TaskListHome extends StatelessWidget {
  const TaskListHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, _) {
        double _screenWidth = MediaQuery.of(context).size.width;
        double _screenHeight = MediaQuery.of(context).size.height;
        List<String> taskList = value.getTaskList();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 60, right: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${taskList[index]}'),
                        GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print("task Completed");
                            }
                            value.taskComplete();
                            value.delTaskFromList(index);
                            _showCongratulationPopup(context);
                          },
                          child: Container(
                            height: _screenHeight * 0.05,
                            width: _screenHeight * .05,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(105, 240, 174, 1),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
          ],
        );
      },
    );
  }
}

class EmptyListHome extends StatelessWidget {
  const EmptyListHome({super.key});

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            'ADD A TASK',
            style: TextStyle(letterSpacing: 8),
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
      ],
    );
  }
}

void _showCongratulationPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(105, 240, 174, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'You have completed this task.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      );
    },
  );
}

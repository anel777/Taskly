import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Taskly/main.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _screenSize = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      backgroundColor: Color(0xFFCBF3F0), // Updated background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Tasks',
          style: TextStyle(letterSpacing: 5),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, value, _) {
          return Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${value.taskCount()}',
                        style: TextStyle(
                            color: Color(0xFFFF9F1C), // Updated color
                            fontSize: _screenSize * 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${value.taskCompleted}',
                        style: TextStyle(
                            color: Color(0xFF2EC4B6), // Updated color
                            fontSize: _screenSize * 70,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${value.taskDeleted}',
                        style: TextStyle(
                            color: Color(0xFFFF6B81), // Updated color
                            fontSize: _screenSize * 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.taskCount(),
                      itemBuilder: (context, index) {
                        List<String> taskList = value.getTaskList();
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: _screenSize * 290,
                                width: _screenSize * 600,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF), // Updated color
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${taskList[index]}'.toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _editPopUp(context, index);
                                          },
                                          child: Container(
                                            height: _screenSize * 60,
                                            width: _screenSize * 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: Color(
                                                  0xFFFFBF69), // Updated color
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            value.taskDelete();
                                            value.delTaskFromList(index);
                                          },
                                          child: Container(
                                            height: _screenSize * 60,
                                            width: _screenSize * 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              color: Color(
                                                  0xFFFF6B81), // Updated color
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: _screenSize * 50,
                  )
                ],
              ),
              Positioned(
                bottom: _screenSize * 80.0, // Adjust as needed
                right: _screenSize * 60.0, // Adjust as needed
                child: GestureDetector(
                  onTap: () {
                    _showAddPopup(context);
                  },
                  child: Container(
                    height: _screenSize * 100,
                    width: _screenSize * 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF2EC4B6)), // Updated color
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddPopup(BuildContext context) {
    double _screenSize = MediaQuery.of(context).size.aspectRatio;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add Task",
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 5),
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "New Task Here !"),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                String taskString = _controller.text;
                // You can perform your add action here
                context.read<TaskProvider>().addTaskToList(taskString);
                print("+++  Added the $taskString");
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_screenSize * 25),
                    color: Color(0xFFFF9F1C)), // Updated color
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_screenSize * 25),
                    color: Colors.grey[400]),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editPopUp(BuildContext context, int index) {
    double _screenSize = MediaQuery.of(context).size.aspectRatio;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Edit Task",
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 5),
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Edited Task Here !"),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                String taskString = _controller.text;
                // You can perform your add action here
                context.read<TaskProvider>().updateTask(taskString, index);
                print("++++Added the $taskString");
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_screenSize * 25),
                    color: Color(0xFFFFBF69)), // Updated color
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(_screenSize * 25),
                    color: Colors.grey[400]),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

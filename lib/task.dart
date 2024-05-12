import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learn/main.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenSize = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.taskCount(),
                  itemBuilder: (context, index) {
                    List<String> taskList = value.getTaskList();
                    return Column(
                      children: [
                        Container(
                          height: _screenSize * 400,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${taskList[index]}'),
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
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.amber[300],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      value.delTaskFromList(index);
                                    },
                                    child: Container(
                                      height: _screenSize * 60,
                                      width: _screenSize * 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.red[300],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showAddPopup(context);
                },
                child: Container(
                  height: _screenSize * 60,
                  width: _screenSize * 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[400]),
                ),
              ),
              SizedBox(
                height: _screenSize * 50,
              )
            ],
          );
        },
      ),
    );
  }

  void _showAddPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Item"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter item"),
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
                color: Colors.green,
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
                color: Colors.grey,
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Task"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter updated task"),
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
                color: Colors.green,
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
                color: Colors.grey,
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

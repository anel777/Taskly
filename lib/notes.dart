import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Taskly/main.dart';
import 'package:Taskly/task.dart';
import 'package:provider/provider.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _screeenSize = MediaQuery.of(context).size.aspectRatio;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Notes',
          style: TextStyle(letterSpacing: 8),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, _) {
          List<String> notesList = provider.getNotesList();
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: _screeenSize * 1000,
              ),
              items: notesList.asMap().entries.map((entry) {
                int index = entry.key;
                String note = entry.value;
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(_screeenSize * 100),
                          ),
                          child: Center(
                            child: Text(
                              note,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 25,
                          child: GestureDetector(
                            onTap: () {
                              provider.deleteNote(index);
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.close,
                                color: Colors.red[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final TextEditingController _noteController =
                  TextEditingController();
              return AlertDialog(
                title: Text('Add Note'),
                content: TextField(
                  controller: _noteController,
                  decoration: InputDecoration(hintText: 'Enter your note'),
                ),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_screeenSize *
                              20), // Adjust the border radius here
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 120, 200, 122)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      Provider.of<TaskProvider>(context, listen: false)
                          .putNote(_noteController.text);
                      _noteController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(_screeenSize *
                              20), // Adjust the border radius here
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 200, 120, 120)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      _noteController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green[300],
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Taskly/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('taskBox');
  await Hive.openBox('notesBox');

  TaskProvider loader = TaskProvider();
  await loader.loadTaskValue();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskly',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class TaskProvider extends ChangeNotifier {
  int _taskCompleted = 0;

  int _taskDeleted = 0;

  TaskProvider() {
    loadTaskValue();
  }

  int get taskCompleted => _taskCompleted;
  int get taskDeleted => _taskDeleted;

  Future<void> loadTaskValue() async {
    _taskCompleted =
        await Hive.box('taskBox').get('taskCompleted', defaultValue: 0);
    _taskDeleted =
        await Hive.box('taskBox').get('taskDeleted', defaultValue: 0);
    notifyListeners();
  }

  List<String> getNotesList() {
    return Hive.box('notesBox').get('notesList', defaultValue: <String>[]);
  }

  void putNote(String note) {
    List<String> notesList = getNotesList();
    notesList.add(note);
    Hive.box('notesBox').put('notesList', notesList);
    notifyListeners();
  }

  void deleteNote(int index) {
    List<String> noteslist = getNotesList();
    noteslist.removeAt(index);
    Hive.box('notesBox').put('notesList', noteslist);
    notifyListeners();
  }

  void taskDelete() {
    _taskDeleted++;
    Hive.box('taskBox').put('taskDeleted', _taskDeleted);
    notifyListeners();
  }

  void taskComplete() {
    _taskCompleted++;
    Hive.box('taskBox').put('taskCompleted', _taskCompleted);
    notifyListeners();
  }

  int taskCount() {
    List<String> taskList = getTaskList();
    return taskList.length;
  }

  List<String> getTaskList() {
    return Hive.box('taskBox').get('taskList', defaultValue: <String>[]);
  }

  void addTaskToList(String data) {
    List<String> taskList = getTaskList();
    taskList.add(data);
    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }

  void delTaskFromList(int index) {
    List<String> taskList = getTaskList();
    taskList.removeAt(index);
    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }

  void updateTask(String updatedValue, int index) {
    List<String> taskList = getTaskList();
    taskList[index] = updatedValue;
    print("Task added $updatedValue at index $index");
    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }
}

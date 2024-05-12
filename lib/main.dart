import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('taskBox');
  await Hive.openBox('goalBox');

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
        title: 'Flutter Demo',
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
  int _goalCompleted = 0;

  TaskProvider() {
    loadTaskValue();
  }

  int get taskCompleted => _taskCompleted;
  int get goalCompleted => _goalCompleted;

  Future<void> loadTaskValue() async {
    _taskCompleted =
        await Hive.box('taskBox').get('taskCompleted', defaultValue: 0);
    notifyListeners();
  }

  void taskComplete() {
    _taskCompleted++;

    Hive.box('taskBox').put('taskCompleted', _taskCompleted);

    notifyListeners();
  }

  void goalComplete() {
    _goalCompleted++;
    notifyListeners();
  }

  int taskCount() {
    List<String> taskList = getTaskList();

    return taskList.length;
  }

  int goalCount() {
    List<String> goalList = getGoalList();
    return goalList.length;
  }

  List<String> getTaskList() {
    return Hive.box('taskBox').get('taskList', defaultValue: <String>[]);
  }

  List<String> getGoalList() {
    return Hive.box('goalBox').get('goalList', defaultValue: <String>[]);
  }

  void addTaskToList(String data) {
    List<String> taskList = getTaskList();
    taskList.add(data);
    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }

  void addGoalToList(String data) {
    List<String> goalList = getGoalList();
    goalList.add(data);
    Hive.box('goalBox').put('goalList', goalList);
    notifyListeners();
  }

  void delTaskFromList(int index) {
    List<String> taskList = getTaskList();

    taskList.removeAt(index);

    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }

  void delGoalFromList(int index) {
    List<String> goalList = getGoalList();
    goalList.removeAt(index);
    //print("Task removed remaining task : ${taskList.length}");
    Hive.box('goalBox').put('goalList', goalList);
    notifyListeners();
  }

  void updateTask(String updatedValue, int index) {
    List<String> taskList = getTaskList();
    taskList[index] = updatedValue;
    print("Task added $updatedValue at index $index");
    Hive.box('taskBox').put('taskList', taskList);
    notifyListeners();
  }

  void updateGoal(String updatedValue, int index) {
    List<String> goalList = getGoalList();
    goalList[index] = updatedValue;
    Hive.box('goalBox').put('taskList', goalList);
    notifyListeners();
  }
}

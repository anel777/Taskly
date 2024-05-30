import 'package:flutter/material.dart';
import 'package:Taskly/home_sections/second_section.dart';
import 'package:Taskly/home_sections/third_section.dart';
import 'package:Taskly/home_sections/top_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [HomeTopSection(), HomeSecondSection(), HomeThirdSection()],
    ));
  }
}

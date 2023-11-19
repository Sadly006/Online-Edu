import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/widgets/course_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Dashboard'),
      ),
      body: ListView.builder(
        itemCount: courseProvider.enrolledCourses.length,
        itemBuilder: (context, index) {
          final course = courseProvider.enrolledCourses[index];
          return CourseCard(course: course);
        },
      ),
    );
  }
}
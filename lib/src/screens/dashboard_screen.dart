import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/auth_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/widgets/course_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  _signOut() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Dashboard'),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Online Edu',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            ListTile(
              title: const Text('Manage Bookmarks'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
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
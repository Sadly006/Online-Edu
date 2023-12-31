import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/auth_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/providers/theme_provider.dart';
import 'package:online_edu/src/screens/bookmark_list_screen.dart';
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
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Online Edu',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.brightness_6,
                      color: Theme.of(context).highlightColor,
                    ),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .swapTheme();
                    },
                  )
                ],
              )
            ),
            ListTile(
              title: Text(
                'Manage Bookmarks',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarksScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
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
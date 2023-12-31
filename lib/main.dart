import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/auth_provider.dart';
import 'package:online_edu/src/providers/bookmark_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/providers/theme_provider.dart';
import 'package:online_edu/src/screens/dashboard_screen.dart';
import 'package:online_edu/src/screens/login_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final themeProvider = ThemeProvider(false);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
        return MaterialApp(
          title: 'Online Edu',
          theme: value.getTheme(),
          routes: {
            '/dashboard': (context) => DashboardScreen(),
          },
          home: const LoginScreen(),
        );}
      ),
    );
  }
}
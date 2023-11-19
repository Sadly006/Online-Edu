import 'package:flutter/material.dart';
import 'package:online_edu/src/models/course_model.dart';

class CourseProvider extends ChangeNotifier {
  // Static dummy courses for demonstration
  final List<Course> _enrolledCourses = [
    Course(id: '1', title: 'Introduction to Flutter', videoUrl: 'https://example.com/flutter-intro.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '2', title: 'Advanced Flutter Topics', videoUrl: 'https://example.com/flutter-advanced.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '3', title: 'Introduction to Flutter', videoUrl: 'https://example.com/flutter-intro.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '4', title: 'Advanced Flutter Topics', videoUrl: 'https://example.com/flutter-advanced.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '5', title: 'Introduction to Flutter', videoUrl: 'https://example.com/flutter-intro.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '6', title: 'Advanced Flutter Topics', videoUrl: 'https://example.com/flutter-advanced.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '7', title: 'Introduction to Flutter', videoUrl: 'https://example.com/flutter-intro.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '8', title: 'Advanced Flutter Topics', videoUrl: 'https://example.com/flutter-advanced.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '9', title: 'Introduction to Flutter', videoUrl: 'https://example.com/flutter-intro.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
    Course(id: '10', title: 'Advanced Flutter Topics', videoUrl: 'https://example.com/flutter-advanced.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png"),
  ];

  List<Course> get enrolledCourses => _enrolledCourses;

  Course? _currentCourse;

  Course? get currentCourse => _currentCourse;

  void setCurrentCourse(Course course) {
    _currentCourse = course;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:online_edu/src/models/course_model.dart';

class CourseProvider extends ChangeNotifier {
  // Static dummy courses for demonstration
  final List<Course> _enrolledCourses = [
    Course(id: '1', title: 'Introduction to Flutter', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 4.8),
    Course(id: '2', title: 'Advanced Flutter Topics', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 3.5),
    Course(id: '3', title: 'Introduction to Flutter', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 4),
    Course(id: '4', title: 'Advanced Flutter Topics', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 2),
    Course(id: '5', title: 'Introduction to Flutter', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 2.5),
    Course(id: '6', title: 'Advanced Flutter Topics', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 3),
    Course(id: '7', title: 'Introduction to Flutter', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 5),
    Course(id: '8', title: 'Advanced Flutter Topics', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 4.8),
    Course(id: '9', title: 'Introduction to Flutter', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 4.8),
    Course(id: '10', title: 'Advanced Flutter Topics', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png", author: "Taosif Sadly", rating: 4.8),
  ];

  List<Course> get enrolledCourses => _enrolledCourses;

  Course? _currentCourse;

  Course? get currentCourse => _currentCourse;

  void setCurrentCourse(Course course) {
    _currentCourse = course;
    notifyListeners();
  }
}
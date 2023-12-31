import 'package:flutter/material.dart';
import 'package:online_edu/src/models/course_model.dart';

class CourseProvider extends ChangeNotifier {
  // Static dummy courses for demonstration
  final List<Course> _enrolledCourses = [
    Course(id: '1', title: 'Flutter, Become a Pro', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://logowik.com/content/uploads/images/flutter5786.jpg", author: "Taosif Sadly", rating: 4.8, modules: {"Introduction": 0, "Widgets": 70, "State Management": 250, "Hot Reload": 400, "Testing": 500, "Conclusion": 520}),
    Course(id: '2', title: 'Introduction to NodeJS', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Node.js_logo.svg/590px-Node.js_logo.svg.png", author: "Taosif Sadly", rating: 3.5, modules: {"Introduction": 0, "Asynchronus Functionality": 100, "Thread Handling": 250, "Handling JSON": 450, "Conclusion": 520}),
    Course(id: '3', title: "Redis: The Complete Developer's Guide", videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://download.logo.wine/logo/Redis/Redis-Logo.wine.png", author: "Taosif Sadly", rating: 5, modules: {"Introduction": 0, "Query Data": 100, "Concurrency": 250, "Hosting": 450, "Conclusion": 520}),
    Course(id: '4', title: 'Create Applications Using Firestore', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://cdn.dribbble.com/users/528264/screenshots/3140440/media/5f34fd1aa2ebfaf2cd548bafeb021c8f.png?resize=800x600&vertical=center", author: "Taosif Sadly", rating: 4.8, modules: {"Introduction": 0, "Authentication": 100, "CRUD": 250, "Cloud Messaging": 450, "Conclusion": 520}),
    Course(id: '5', title: 'PHP Laravel for Begineers', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://logowik.com/content/uploads/images/laravel8530.jpg", author: "Taosif Sadly", rating: 4, modules: {"Introduction": 0, "Setup": 100, "Routing": 250, "ORM": 350, "API": 450, "Conclusion": 520}),
    Course(id: '6', title: 'Go Bootcamp', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://openupthecloud.com/wp-content/uploads/2020/01/Golang.png?ezimgfmt=ng%3Awebp%2Fngcb2%2Frs%3Adevice%2Frscb2-1", author: "Taosif Sadly", rating: 2, modules: {"Introduction": 0, "Data Structure": 100, "API": 250, "Concurrency": 350, "Conclusion": 520}),
    Course(id: '7', title: 'VueJS - Mastering Web Apps', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://kinsta.com/wp-content/uploads/2022/03/what-is-vue-3.png", author: "Taosif Sadly", rating: 2.5, modules: {"Introduction": 0, "Conclusion": 520}),
    Course(id: '8', title: 'Deep Dive in C++', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://logowik.com/content/uploads/images/911_c_logo.jpg", author: "Taosif Sadly", rating: 3, modules: {"Introduction": 0, "OOP": 100, "Overloading": 250, "Overriding": 450, "Conclusion": 520}),
    Course(id: '9', title: 'Spring MVC, Spring Boot and Rest COntrollers', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://miro.medium.com/v2/resize:fit:720/format:webp/1*-uckV8DOh3l0bCvqZ73zYg.png", author: "Taosif Sadly", rating: 4.2, modules: {"Introduction": 0, "Launch Server": 100, "API": 300, "MVC": 450, "Conclusion": 520}),
    Course(id: '10', title: 'Data Modeling for MongoDB', videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', imageUrl: "https://www.thecrazyprogrammer.com/wp-content/uploads/2021/09/Mongodb-history-1024x341.png?ezimgfmt=ng:webp/ngcb1", author: "Taosif Sadly", rating: 4.8, modules: {"Introduction": 0, "Shell": 100, "Queries": 200, "Indexing": 300, "Release": 450, "Conclusion": 520}),
  ];

  List<Course> get enrolledCourses => _enrolledCourses;

  Course? _currentCourse;

  Course? get currentCourse => _currentCourse;

  void setCurrentCourse(Course course) {
    _currentCourse = course;
    notifyListeners();
  }
}
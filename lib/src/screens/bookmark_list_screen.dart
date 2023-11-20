import 'package:flutter/material.dart';
import 'package:online_edu/src/models/course_model.dart';
import 'package:online_edu/src/providers/bookmark_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {

  List<Course> bookmakedCourses = [];

  getBookMarkedCourses(){
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
    CourseProvider courseProvider = Provider.of<CourseProvider>(context, listen: false);

    List<Course> allCourses = courseProvider.enrolledCourses;

    for (Course course in allCourses) {
      List<Duration> bookmarks = bookmarkProvider.getBookmarks(course.id);
      if(bookmarks.isNotEmpty){
        bookmakedCourses.add(course);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getBookMarkedCourses();
  }

  @override
  Widget build(BuildContext context) {
    BookmarkProvider bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmakedCourses.length,
        itemBuilder: (context, index) {
          String courseId = bookmakedCourses[index].id;

          return Card(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(7),
              ),
              // height: 80,
              width: displayWidth(context) * 0.46,
              child: Column(
                children: [
                  Material(
                    elevation: 10,
                    child: ListTile(
                      leading: Image(
                        image: NetworkImage(
                            bookmakedCourses[index].imageUrl.toString()),
                        fit: BoxFit.cover,
                      ),
                      title: Text(bookmakedCourses[index].title),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: bookmarkProvider.getBookmarks(courseId).length,
                        itemBuilder: (context, idx) {
                          List<Duration>? courseBookmarks = bookmarkProvider.getBookmarks(courseId);
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                              height: 30,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  const Padding(padding: EdgeInsets.all(5)),
                                  Text(
                                    "${courseBookmarks[index].inHours}:${courseBookmarks[index].inMinutes.remainder(60)}:${(courseBookmarks[index].inSeconds.remainder(60))}",
                                    
                                    style: const TextStyle(
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      ),
                    )
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }
}

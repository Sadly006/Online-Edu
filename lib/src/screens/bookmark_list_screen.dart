import 'package:flutter/material.dart';
import 'package:online_edu/src/models/course_model.dart';
import 'package:online_edu/src/providers/bookmark_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:online_edu/src/screens/video_player_screen.dart';
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
    CourseProvider courseProvider = Provider.of<CourseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Bookmarks',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
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
              width: displayWidth(context) * 0.46,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: ListTile(
                        leading: Image(
                          image: NetworkImage(
                              bookmakedCourses[index].imageUrl.toString()),
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          bookmakedCourses[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                    child: Text(
                      "Bookmarks",
                      style: TextStyle(
                        color: Theme.of(context).highlightColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bookmarkProvider.getBookmarks(courseId).length,
                      itemBuilder: (context, idx) {
                        List<Duration>? courseBookmarks = bookmarkProvider.getBookmarks(courseId);
                        return Dismissible(
                          direction: DismissDirection.startToEnd,
                          key: ValueKey<dynamic>(courseBookmarks[idx]),
                          background: Card(
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,
                            child: const Center(
                              child: Row(
                                children: [
                                  Padding(padding: EdgeInsets.all(2)),
                                  Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Text(
                                    "Remove",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onDismissed: (DismissDirection direction) {
                            bookmarkProvider.deleteBookmark(courseId, courseBookmarks[idx]);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Bookmark Removed"),
                            ));
                          },
                          child: GestureDetector(
                            onTap: () {
                              courseProvider.setCurrentCourse(bookmakedCourses[index]);
                              int seekTo = courseBookmarks[idx].inSeconds;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(seekTo: seekTo),
                                ),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
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
                                      "${courseBookmarks[idx].inHours}:${courseBookmarks[idx].inMinutes.remainder(60)}:${(courseBookmarks[idx].inSeconds.remainder(60))}",
                                      style: TextStyle(
                                        color: Theme.of(context).highlightColor,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

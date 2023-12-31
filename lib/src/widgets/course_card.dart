import 'package:flutter/material.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:online_edu/src/screens/video_player_screen.dart';
import 'package:online_edu/src/widgets/rating_widget.dart';
import 'package:provider/provider.dart';
import '../models/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  getImage() {
    if (course.imageUrl.isNotEmpty) {
      return DecorationImage(
        image: NetworkImage(
            course.imageUrl.toString()),
        fit: BoxFit.contain,
      );
    } else {
      return const DecorationImage(
        image: AssetImage("assets/no-image.png"),
        fit: BoxFit.contain,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    return Card(
      child: Flexible(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(7),
          ),
          // height: displayHeight(context) * 0.27,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: displayHeight(context) * 0.15,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7)),
                    image: getImage(),
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            course.title,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            course.author,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: RatingWidget(rating: course.rating,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            courseProvider.setCurrentCourse(course);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(seekTo: 0),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: SizedBox(
                            width: displayWidth(context) * 0.2,
                            child: Center(
                              child: Row(
                                children: [
                                  const Icon(Icons.play_arrow_rounded),
                                  Text(
                                    "Continue",
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.03
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
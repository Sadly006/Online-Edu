import 'package:flutter/material.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import '../models/course_model.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  getImage() {
    if (course.imageUrl.isNotEmpty) {
      return DecorationImage(
        image: NetworkImage(
            course.imageUrl.toString()),
        fit: BoxFit.cover,
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
    return Card(
      child: GestureDetector(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(7),
                ),
                height: 300,
                width: displayWidth(context) * 0.46,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(7)),
                          image: getImage(),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        course.title,
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: SizedBox(
                            width: displayWidth(context) * 0.2,
                            child: const Center(
                              child: Row(
                                children: [
                                  Icon(Icons.play_arrow_rounded),
                                  Text("Continue")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
    );
  }
}
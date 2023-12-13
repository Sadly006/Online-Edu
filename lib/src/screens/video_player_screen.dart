import 'package:flutter/material.dart';
import 'package:online_edu/src/models/bookmark_marker_model.dart';
import 'package:online_edu/src/providers/bookmark_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/models/video_progress_colors_custom.dart';
import 'package:online_edu/src/screen_sizes/screen_size_page.dart';
import 'package:online_edu/src/widgets/video_progress_indicator_custom.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final int seekTo;

  VideoPlayerScreen({Key? key, required this.seekTo}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _showControls = true;
  bool _isSeeking = false;
  List<Duration> bookmarks = [];

  @override
  void initState() {
    super.initState();
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    _controller = VideoPlayerController.networkUrl(Uri.parse(courseProvider.currentCourse!.videoUrl))
      ..initialize().then((_) {
        _controller.seekTo(Duration(seconds: widget.seekTo));
        setState(() {
          _controller.play();
          _isPlaying = true;
        });
      });

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Congratulations!!"),
              content: const Text("You have completed this course successfully"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName("/dashboard"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: SizedBox(
                    width: displayWidth(context) * 0.3,
                    child: const Center(
                      child: Text("Claim your certificate")
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
      setState(() {});
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying ? _controller.pause() : _controller.play();
      _isPlaying = !_isPlaying;
    });
  }

  void _seek(bool forward) {
    const seekDuration = Duration(seconds: 10);
    final currentPosition = _controller.value.position;

    setState(() {
      _isSeeking = true;
    });

    if (forward) {
      _controller.seekTo(currentPosition + seekDuration);
    } else {
      _controller.seekTo(currentPosition - seekDuration);
    }

    _controller.play().then((_) {
      setState(() {
        _isSeeking = false;
      });
    });
  }

  void _seekTo(int seconds) {
    Duration seekDuration = Duration(seconds: seconds);

    setState(() {
      _isSeeking = true;
    });

    _controller.seekTo(seekDuration);

    _controller.play().then((_) {
      setState(() {
        _isSeeking = false;
      });
    });
  }

  void _seekToModule(int seconds) {
    Duration seekDuration = Duration(seconds: seconds);

    setState(() {
      _isSeeking = true;
    });

    _controller.seekTo(seekDuration);

    _controller.play().then((_) {
      setState(() {
        _isSeeking = false;
      });
    });
  }

  void _addBookmark() {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    setState(() {
      Provider.of<BookmarkProvider>(context, listen: false).addBookmark(courseProvider.currentCourse!.id, _controller.value.position);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Added Bookmark"),
    ));
  }

  int _findNextValue(Map<String, int> modules, int value, bool next) {
    int seekTo = value;

    if(next){
      for (var entry in modules.entries) {
        if (entry.value > value) {
          seekTo = entry.value;
          break;
        }
      }
    } else {
      int flag = 0;
      List<MapEntry<String, int>> reversedEntries = modules.entries.toList().reversed.toList();

      for (var entry in reversedEntries) {
        if(entry.value <= value){
          flag++;
        }
        if(flag == 2){
          seekTo = entry.value;
          break;
        }
      }
    }    

    return seekTo;
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    Map<String, int> modules = courseProvider.currentCourse!.modules;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Video Player'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        onDoubleTapDown: (details) {
          final double screenWidth = MediaQuery.of(context).size.width;
          final double tapPosition = details.globalPosition.dx;
          final bool seekForward = tapPosition > screenWidth / 2;

          _seek(seekForward);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: displayHeight(context) * 0.3,
              pinned: true,
              collapsedHeight: displayHeight(context) * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    if (!_controller.value.isInitialized || _isSeeking)
                      const CircularProgressIndicator()
                    else
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    if (_controller.value.isInitialized && _showControls && !_isSeeking)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_controller.value.isInitialized)
                              VideoProgressIndicatorCustom(
                                _controller,
                                allowScrubbing: true,
                                colors: VideoProgressColorsCustom(
                                  playedColor: Colors.amber,
                                  bufferedColor: Colors.grey,
                                  backgroundColor: Colors.black,
                                ),
                                markers: bookmarkProvider.getBookmarks(courseProvider.currentCourse!.id).map((bookmark) {
                                  return BookmarkMarker(
                                    bookmark,
                                    color: Colors.green,
                                  );
                                }).toList(),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.fast_rewind),
                                  onPressed: () {
                                    int previousModulePosition = _findNextValue(modules, _controller.value.position.inSeconds, false);
                                    _seekTo(previousModulePosition);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                                  onPressed: _togglePlayPause,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.fast_forward),
                                  onPressed: () {
                                    int nextModulePosition = _findNextValue(modules, _controller.value.position.inSeconds, true);
                                    _seekTo(nextModulePosition);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.bookmark),
                                  onPressed: _addBookmark,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Course Modules',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).highlightColor
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int idx) {
                  final key = modules.keys.elementAt(idx);
                  final value = modules[key];

                  return GestureDetector(
                      onTap: () {
                        _seekToModule(value!);
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
                                child: Center(
                                  child: Image(
                                    image: NetworkImage(
                                        courseProvider.currentCourse!.imageUrl.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(5)),
                              Text(
                                key,
                                style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                },
                childCount: modules.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
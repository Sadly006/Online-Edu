import 'package:flutter/material.dart';
import 'package:online_edu/src/models/bookmark_marker_model.dart';
import 'package:online_edu/src/providers/bookmark_provider.dart';
import 'package:online_edu/src/providers/course_provider.dart';
import 'package:online_edu/src/widgets/video_progress_colors_custom.dart';
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
      // Update the UI when the playback position changes
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

  void _addBookmark() {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    setState(() {
      // bookmarks.add(_controller.value.position);
      Provider.of<BookmarkProvider>(context, listen: false).addBookmark(courseProvider.currentCourse!.id, _controller.value.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

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
        child: Center(
          child: Stack(
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
                            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: _togglePlayPause,
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
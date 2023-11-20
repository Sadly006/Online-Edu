import 'package:flutter/material.dart';
import 'package:online_edu/src/models/bookmark_marker_model.dart';
import 'package:online_edu/src/widgets/video_progress_colors_custom.dart';
import 'package:video_player/video_player.dart';

class VideoProgressIndicatorCustom extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoProgressColorsCustom colors;
  final bool allowScrubbing;
  final List<BookmarkMarker>? markers;

  const VideoProgressIndicatorCustom(
    this.controller, {super.key, 
    required this.colors,
    this.allowScrubbing = false,
    this.markers,
  });

  @override
  _VideoProgressIndicatorCustomState createState() => _VideoProgressIndicatorCustomState();
}

class _VideoProgressIndicatorCustomState extends State<VideoProgressIndicatorCustom> {
  double? _dragValue;
  double? _dragStart;
  double? _dragEnd;

  @override
  Widget build(BuildContext context) {
    final double played = widget.controller.value.position.inMilliseconds.toDouble();
    final double buffered = widget.controller.value.buffered.isNotEmpty
        ? widget.controller.value.buffered.last.end.inMilliseconds.toDouble()
        : 0.0;
    final double total = widget.controller.value.duration.inMilliseconds.toDouble();

    return SizedBox(
      height: 20.0,
      child: GestureDetector(
        onTapDown: (details) {
          if (widget.allowScrubbing) {
            _onTapDown(details);
          }
        },
        onHorizontalDragStart: (details) {
          if (widget.allowScrubbing) {
            _onDragStart(details);
          }
        },
        onHorizontalDragUpdate: (details) {
          if (widget.allowScrubbing) {
            _onDragUpdate(details);
          }
        },
        onHorizontalDragEnd: (details) {
          if (widget.allowScrubbing) {
            _onDragEnd();
          }
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 5.0,
              color: widget.colors.backgroundColor,
            ),
            if (buffered > 0)
              Container(
                width: (buffered / total) * MediaQuery.of(context).size.width,
                height: 5.0,
                color: widget.colors.bufferedColor,
              ),
            if (played > 0)
              Container(
                width: (played / total) * MediaQuery.of(context).size.width,
                height: 5.0,
                color: widget.colors.playedColor,
              ),
            if (widget.markers != null)
              ...widget.markers!.map((marker) {
                final markerPosition = (marker.position.inMilliseconds / total) * MediaQuery.of(context).size.width;
                return Positioned(
                  left: markerPosition,
                  child: Container(
                    width: 2.0,
                    height: 10.0,
                    color: marker.color,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double value = details.localPosition.dx / MediaQuery.of(context).size.width;
    widget.controller.seekTo(Duration(milliseconds: (value * widget.controller.value.duration.inMilliseconds).round()));
  }

  void _onDragStart(DragStartDetails details) {
    _dragStart = details.localPosition.dx;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _dragEnd = details.localPosition.dx;
    final double dragValue = (_dragStart! - _dragEnd!) / MediaQuery.of(context).size.width;
    setState(() {
      _dragValue = dragValue;
    });
  }

  void _onDragEnd() {
    if (_dragValue != null) {
      final double value = (_dragValue! * widget.controller.value.duration.inMilliseconds).round().toDouble();
      widget.controller.seekTo(Duration(milliseconds: value.toInt()));
      setState(() {
        _dragValue = null;
        _dragStart = null;
        _dragEnd = null;
      });
    }
  }
}
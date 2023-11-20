import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  Map<String, List<Duration>> _bookmarks = {};

  List<Duration> getBookmarks(String id) {
    return _bookmarks[id] ?? [];
  }

  void addBookmark(String id, Duration position) {
    List<Duration> _courseWiseBookMarks = _bookmarks[id] ?? [];
    _courseWiseBookMarks.add(position);
    _bookmarks[id] = _courseWiseBookMarks;
    notifyListeners();
  }
}
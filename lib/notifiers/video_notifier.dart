import 'package:flutter/widgets.dart';
import 'package:shadowing_reader/models/video.dart';

class VideoNotifier extends ChangeNotifier {
  bool _hasVideo = false;
  MyVideo _video = MyVideo.empty();

  bool get hasVideo => _hasVideo;
  MyVideo get video => _video;

  void setWebVideo(MyVideo video) {
    _video = video;
    _hasVideo = true;
    notifyListeners();
  }

  void setAppVideo(MyVideo video) {
    // TODO
    _video = video;
    _hasVideo = true;
    notifyListeners();
  }
}
class MyVideo {
  final String title;
  final String thumbnail;
  final Uri webVideoUrl;

  MyVideo({
    required this.title,
    required this.thumbnail,
    required this.webVideoUrl,
  });

  static MyVideo empty() {
    return MyVideo(
      title: '',
      thumbnail: '',
      webVideoUrl: Uri(),
    );
  }

  bool isEmpty() {
    return title.isEmpty && thumbnail.isEmpty && webVideoUrl.toString().isEmpty;
  }
}
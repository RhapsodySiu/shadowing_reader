class VideoLine {
  final String title;
  final String subtitle;
  final String timestamp;

  const VideoLine({
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}

class ActiveVideoLine extends VideoLine {
  final double progress;

  const ActiveVideoLine({
    required super.title,
    required super.subtitle,
    required super.timestamp,
    required this.progress,
  });
}
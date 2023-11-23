class Course {
  final String id;
  final String title;
  final String videoUrl;
  final String imageUrl;
  final String author;
  final double rating;
  final Map<String, int> modules;

  Course({required this.id, required this.title, required this.videoUrl, required this.imageUrl, required this.author, required this.rating, required this.modules});
}
class Todo {
  final String title;
  final DateTime createdAt;
  bool isFinished;

  Todo({
    required this.title,
    required this.createdAt,
    this.isFinished = false,
  });
}

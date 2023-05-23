class Todo {
  final String title;
  final String description;
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}

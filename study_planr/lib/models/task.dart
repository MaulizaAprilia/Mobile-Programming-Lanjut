class Task {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final Priority priority;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.priority,
    this.isCompleted = false,
  });
}

enum Priority { high, medium, low }
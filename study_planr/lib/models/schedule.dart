class Schedule {
  final String id;
  final String subject;
  final String room;
  final String lecturer;
  final DateTime startTime;
  final DateTime endTime;
  final int dayOfWeek; // 1-7 (Senin-Minggu)

  Schedule({
    required this.id,
    required this.subject,
    required this.room,
    required this.lecturer,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
  });
}
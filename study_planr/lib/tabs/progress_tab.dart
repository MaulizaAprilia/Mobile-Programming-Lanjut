import 'package:flutter/material.dart';

class ProgressTab extends StatefulWidget {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  ProgressTabState createState() => ProgressTabState();
}

class ProgressTabState extends State<ProgressTab> {
  // Data dummy untuk contoh
  final Map<String, dynamic> _progressData = {
    'tasksCompleted': 15,
    'totalTasks': 20,
    'attendanceRate': 0.90,
    'weeklyProgress': [65, 70, 85, 75, 90],
    'subjectProgress': [
      {
        'subject': 'Mobile Programming',
        'completion': 0.85,
        'color': Colors.indigo,
      },
      {
        'subject': 'Basis Data',
        'completion': 0.75,
        'color': Colors.orange,
      },
      {
        'subject': 'Kecerdasan Buatan',
        'completion': 0.65,
        'color': Colors.green,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    double taskCompletionRate =
        _progressData['tasksCompleted'] / _progressData['totalTasks'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress Overview',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: taskCompletionRate,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          const SizedBox(height: 8),
          Text(
            'Tugas selesai: ${_progressData['tasksCompleted']} dari ${_progressData['totalTasks']}',
          ),

          const SizedBox(height: 24),
          Text(
            'Attendance Rate',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _progressData['attendanceRate'],
            backgroundColor: Colors.grey[300],
            color: Colors.teal,
          ),
          const SizedBox(height: 8),
          Text(
            'Kehadiran: ${(_progressData['attendanceRate'] * 100).toStringAsFixed(0)}%',
          ),

          const SizedBox(height: 24),
          Text(
            'Progress per Subject',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Column(
            children: List.generate(
              _progressData['subjectProgress'].length,
              (index) {
                final subject = _progressData['subjectProgress'][index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subject['subject']),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: subject['completion'],
                        color: subject['color'],
                        backgroundColor: Colors.grey[300],
                      ),
                      Text(
                        '${(subject['completion'] * 100).toStringAsFixed(0)}% selesai',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

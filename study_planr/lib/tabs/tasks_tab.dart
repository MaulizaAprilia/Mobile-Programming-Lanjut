import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../screens/add_task_screen.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);

  @override
  TasksTabState createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  // Data dummy untuk contoh
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Mobile Programming - UTS',
      description: 'Persiapkan proyek untuk UTS',
      deadline: DateTime.now().add(const Duration(days: 2)),
      priority: Priority.high,
    ),
    Task(
      id: '2',
      title: 'Matematika Diskrit - Tugas 3',
      description: 'Kerjakan halaman 45-50',
      deadline: DateTime.now().add(const Duration(days: 4)),
      priority: Priority.medium,
    ),
    Task(
      id: '3',
      title: 'Basis Data - Normalisasi',
      description: 'Latihan soal normalisasi database',
      deadline: DateTime.now().add(const Duration(days: 7)),
      priority: Priority.low,
    ),
    Task(
      id: '4',
      title: 'Pemrograman Web - Project',
      description: 'Kerjakan wireframe dan mockup website',
      deadline: DateTime.now().add(const Duration(days: 10)),
      priority: Priority.high,
      isCompleted: true,
    ),
  ];

  String _filterStatus = 'semua'; // 'semua', 'selesai', 'belum'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _filteredTasks().isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredTasks().length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks()[index];
                      return TaskCard(
                        task: task,
                        onStatusChanged: (value) {
                          setState(() {
                            task.isCompleted = value!;
                          });
                        },
                        onTap: () => _showTaskDetails(task),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          // Refresh data if needed after returning from add task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Tugas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Semua', 'semua'),
                const SizedBox(width: 8),
                _buildFilterChip('Belum Selesai', 'belum'),
                const SizedBox(width: 8),
                _buildFilterChip('Selesai', 'selesai'),
                const SizedBox(width: 8),
                _buildFilterChip('Prioritas Tinggi', 'tinggi'),
                const SizedBox(width: 8),
                _buildFilterChip('Prioritas Sedang', 'sedang'),
                const SizedBox(width: 8),
                _buildFilterChip('Prioritas Rendah', 'rendah'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = value;
        });
      },
      selectedColor: Colors.indigo.withOpacity(0.2),
      checkmarkColor: Colors.indigo,
      labelStyle: TextStyle(
        color: isSelected ? Colors.indigo : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  List<Task> _filteredTasks() {
    switch (_filterStatus) {
      case 'selesai':
        return _tasks.where((task) => task.isCompleted).toList();
      case 'belum':
        return _tasks.where((task) => !task.isCompleted).toList();
      case 'tinggi':
        return _tasks.where((task) => task.priority == Priority.high).toList();
      case 'sedang':
        return _tasks.where((task) => task.priority == Priority.medium).toList();
      case 'rendah':
        return _tasks.where((task) => task.priority == Priority.low).toList();
      case 'semua':
      default:
        return _tasks;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada tugas ditemukan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan tugas baru dengan menekan tombol + di bawah',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(task.priority).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getPriorityText(task.priority),
                      style: TextStyle(
                        color: _getPriorityColor(task.priority),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push to edit task screen
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Navigator.pop(context);
                      _confirmDeleteTask(task);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year}',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      task.isCompleted = !task.isCompleted;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: task.isCompleted
                        ? Colors.orange
                        : Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    task.isCompleted
                        ? 'Tandai Belum Selesai'
                        : 'Tandai Selesai',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        );
      },
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  String _getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.high:
        return 'Prioritas Tinggi';
      case Priority.medium:
        return 'Prioritas Sedang';
      case Priority.low:
        return 'Prioritas Rendah';
    }
  }

  void _confirmDeleteTask(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Tugas'),
          content: Text('Apakah Anda yakin ingin menghapus tugas "${task.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('BATAL'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeWhere((t) => t.id == task.id);
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('HAPUS'),
            ),
          ],
        );
      },
    );
  }
}
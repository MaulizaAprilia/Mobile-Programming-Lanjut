import 'package:flutter/material.dart';
import '../models/schedule.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  ScheduleTabState createState() => ScheduleTabState();
}

class ScheduleTabState extends State<ScheduleTab> {
  // Data dummy untuk contoh jadwal kuliah
  final List<Schedule> _schedules = [
    Schedule(
      id: '1',
      subject: 'Mobile Programming Lanjut',
      room: 'Lab Komputer 3',
      lecturer: 'Ade Kurniawan, S.Pd., M.Pd.T',
      startTime: DateTime(2025, 4, 8, 8, 0), // 8:00
      endTime: DateTime(2025, 4, 8, 9, 40), // 9:40
      dayOfWeek: 2, // Selasa
    ),
    Schedule(
      id: '2',
      subject: 'Pemrograman Web',
      room: 'Ruang 201',
      lecturer: 'Dr. Ahmad Fauzi',
      startTime: DateTime(2025, 4, 8, 13, 0), // 13:00
      endTime: DateTime(2025, 4, 8, 14, 40), // 14:40
      dayOfWeek: 2, // Selasa
    ),
    Schedule(
      id: '3',
      subject: 'Matematika Diskrit',
      room: 'Ruang 304',
      lecturer: 'Prof. Dr. Indra Wijaya',
      startTime: DateTime(2025, 4, 9, 10, 0), // 10:00
      endTime: DateTime(2025, 4, 9, 11, 40), // 11:40
      dayOfWeek: 3, // Rabu
    ),
    Schedule(
      id: '4',
      subject: 'Basis Data',
      room: 'Lab Database',
      lecturer: 'Dr. Ratna Sari, M.Kom',
      startTime: DateTime(2025, 4, 9, 14, 0), // 14:00
      endTime: DateTime(2025, 4, 9, 15, 40), // 15:40
      dayOfWeek: 3, // Rabu
    ),
    Schedule(
      id: '5',
      subject: 'Sistem Operasi',
      room: 'Lab Komputer 1',
      lecturer: 'Ir. Budi Santoso, M.T',
      startTime: DateTime(2025, 4, 10, 8, 0), // 8:00
      endTime: DateTime(2025, 4, 10, 10, 30), // 10:30
      dayOfWeek: 4, // Kamis
    ),
  ];

  int _selectedDay = DateTime.now().weekday;
  final List<String> _dayNames = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDaySelector(),
        Expanded(
          child: _filteredSchedules().isEmpty
              ? _buildEmptyState()
              : _buildScheduleList(),
        ),
      ],
    );
  }

  Widget _buildDaySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(7, (index) {
            final day = index + 1; // 1-7 for Monday-Sunday
            final isSelected = _selectedDay == day;
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = day;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.indigo : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  _dayNames[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  List<Schedule> _filteredSchedules() {
    return _schedules
        .where((schedule) => schedule.dayOfWeek == _selectedDay)
        .toList()
      ..sort((a, b) => a.startTime.hour.compareTo(b.startTime.hour));
  }

  Widget _buildScheduleList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredSchedules().length,
      itemBuilder: (context, index) {
        final schedule = _filteredSchedules()[index];
        final bool isLastItem = index == _filteredSchedules().length - 1;
        
        return Column(
          children: [
            if (index == 0) _buildTimeIndicator(),
            _buildScheduleCard(schedule),
            if (!isLastItem)
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Container(
                  height: 30,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTimeIndicator() {
    final now = DateTime.now();
    final currentHour = now.hour;
    final currentMinute = now.minute;
    
    // Check if there are any ongoing classes
    final ongoingClasses = _filteredSchedules().where((schedule) {
      final startHour = schedule.startTime.hour;
      final startMinute = schedule.startTime.minute;
      final endHour = schedule.endTime.hour;
      final endMinute = schedule.endTime.minute;
      
      return (currentHour > startHour || 
             (currentHour == startHour && currentMinute >= startMinute)) &&
             (currentHour < endHour || 
             (currentHour == endHour && currentMinute <= endMinute));
    }).toList();
    
    if (ongoingClasses.isEmpty) {
      return Container(); // No ongoing classes
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.green.shade700),
          const SizedBox(width: 8),
          Text(
            'Sedang Berlangsung: ${ongoingClasses.first.subject}',
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Schedule schedule) {
    // Format time to HH:MM
    String formatTime(DateTime time) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
    
    return InkWell(
      onTap: () => _showScheduleDetails(schedule),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${formatTime(schedule.startTime)} - ${formatTime(schedule.endTime)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.menu_book,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            schedule.subject,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  schedule.lecturer,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                schedule.room,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Pertemuan Rutin',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada jadwal kuliah',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Anda tidak memiliki jadwal untuk hari ${_dayNames[_selectedDay - 1]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _showScheduleDetails(Schedule schedule) {
    // Format time to HH:MM
    String formatTime(DateTime time) {
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    }
    
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
                      color: Colors.indigo.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Detail Jadwal',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.push to edit schedule screen
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                schedule.subject,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailRow(Icons.access_time, 
                'Waktu: ${formatTime(schedule.startTime)} - ${formatTime(schedule.endTime)}'),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.calendar_today, 
                'Hari: ${_dayNames[schedule.dayOfWeek - 1]}'),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.person, 'Dosen: ${schedule.lecturer}'),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.location_on, 'Ruang: ${schedule.room}'),
              const SizedBox(height: 24),
              const Text(
                'Catatan Kuliah:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Text(
                  'Belum ada catatan untuk kuliah ini. Tambahkan catatan untuk membantu belajar Anda.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implementasi set pengingat
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.notifications_active),
                      label: const Text('Set Pengingat'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implementasi tambah catatan
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.note_add),
                  label: const Text('Tambah Catatan'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
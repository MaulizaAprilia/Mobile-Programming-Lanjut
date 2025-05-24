import 'package:flutter/material.dart';
import '../tabs/dashboard_tab.dart';
import '../tabs/tasks_tab.dart';
import '../tabs/schedule_tab.dart';
import '../tabs/progress_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyPlanr'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementasi pencarian
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Implementasi notifikasi
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Beranda'),
            Tab(icon: Icon(Icons.assignment), text: 'Tugas'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Jadwal'),
            Tab(icon: Icon(Icons.bar_chart), text: 'Progres'),
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DashboardTab(),
          TasksTab(),
          ScheduleTab(),
          ProgressTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implementasi tambah tugas/jadwal
          _showAddOptions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Mauliza Aprilia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'NIM: 22346014',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {
              // Navigasi ke pengaturan
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Bantuan'),
            onTap: () {
              // Navigasi ke bantuan
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Keluar'),
            onTap: () {
              // Implementasi logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tambah Baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.assignment, color: Colors.indigo),
                title: const Text('Tugas Baru'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigasi ke tambah tugas
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.indigo),
                title: const Text('Jadwal Kuliah'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigasi ke tambah jadwal
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
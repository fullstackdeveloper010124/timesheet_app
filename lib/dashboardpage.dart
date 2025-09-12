import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'projecttaskmanagement.dart';
import 'calendartimesheetpage.dart';
import 'settings_page.dart';
import 'leave_application_page.dart';


void main() {
  runApp(const MaterialApp(home: DashboardPage()));
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardContent(),
    const ProjectTaskManagementPage(),
    const CalendarTimesheetPage(),
      LeaveApplicationPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF5B41F5),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Timesheet'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Apply Leave'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 60, left: 20, bottom: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF5B41F5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: const Text(
            "Dashboard",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 20),

        // Month Dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: const [
              Text(
                "May 2025",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Circular Indicator
        CircularPercentIndicator(
          radius: 70.0,
          lineWidth: 12.0,
          percent: 0.7,
          center: const Text(
            "50:45\nhrs",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          progressColor: const Color(0xFF5B41F5),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),

        const SizedBox(height: 20),

        // Worked and Remaining
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _timeBox("Worked", "120:30 hrs"),
              _timeBox("Remaining", "120:30 hrs"),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Recent Entries
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent Entries",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _entryTile("Tue, May 7", "2:45hrs", "Project A"),
              _entryTile("Mon, May 6", "6:15 hrs", "Development"),
              _entryTile("Fri, May 3", "8:00 hrs", "Development"),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _timeBox(String label, String time) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _entryTile extends StatelessWidget {
  final String date;
  final String time;
  final String project;

  const _entryTile(this.date, this.time, this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$date • $time",
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            project,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

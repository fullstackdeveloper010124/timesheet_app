import 'package:flutter/material.dart';
import 'app_drawer_admin.dart';
import 'add_task_page.dart';
import 'calendartimesheetpage.dart';
import 'leave_application_page.dart';
import 'leave_status_page.dart';
import 'mytimesheet.dart';
import 'projecttaskmanagement.dart';
import 'settings_page.dart';
import 'timesheet_approval.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF5B41F5),
      ),
      drawer: const AdminAppDrawer(),
      backgroundColor: const Color(0xFFF7F8FC),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _FeatureCard(
              icon: Icons.people_alt,
              color: const Color(0xFF6366F1),
              title: 'Timesheet Review',
              onTap: () => _open(context, const TimesheetReviewPage()),
            ),
            _FeatureCard(
              icon: Icons.event_available,
              color: const Color(0xFF22C55E),
              title: 'Leave Applications',
              onTap: () => _open(context, const LeaveApplicationPage()),
            ),
            _FeatureCard(
              icon: Icons.list_alt,
              color: const Color(0xFFF59E0B),
              title: 'Leave Status',
              onTap: () => _open(context, LeaveStatusPage()),
            ),
            _FeatureCard(
              icon: Icons.calendar_month,
              color: const Color(0xFF3B82F6),
              title: 'Calendar & Timesheet',
              onTap: () => _open(context, const CalendarTimesheetPage()),
            ),
            _FeatureCard(
              icon: Icons.task,
              color: const Color(0xFF8B5CF6),
              title: 'Project & Tasks',
              onTap: () => _open(context, const ProjectTaskManagementPage()),
            ),
            _FeatureCard(
              icon: Icons.add_task,
              color: const Color(0xFF10B981),
              title: 'Add Task',
              onTap: () => _open(context, const AddTaskPage()),
            ),
            _FeatureCard(
              icon: Icons.timer,
              color: const Color(0xFFEF4444),
              title: 'My Timesheets',
              onTap: () => _open(context, const MyTimesheetPage()),
            ),
            _FeatureCard(
              icon: Icons.settings,
              color: const Color(0xFF0EA5E9),
              title: 'Settings',
              onTap: () => _open(context, const SettingsPage()),
            ),
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 30,
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

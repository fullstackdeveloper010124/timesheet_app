import 'package:flutter/material.dart';
import 'dashboardpage_admin.dart';
import 'add_task_page.dart';
import 'calendartimesheetpage.dart';
import 'leave_application_page.dart';
import 'leave_status_page.dart';
import 'mytimesheet.dart';
import 'projecttaskmanagement.dart';
import 'settings_page.dart';
import 'timesheet_approval.dart';
import '../login_page.dart';

class AdminAppDrawer extends StatelessWidget {
  const AdminAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF5B41F5)),
            child: Text('Admin Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _nav(context, Icons.dashboard, 'Dashboard', const DashboardPage()),
          _nav(context, Icons.timer, 'My Timesheets', const MyTimesheetPage()),
          _nav(context, Icons.calendar_month, 'Calendar & Timesheet',
              const CalendarTimesheetPage()),
          _nav(context, Icons.task, 'Project & Tasks',
              const ProjectTaskManagementPage()),
          _nav(context, Icons.add_task, 'Add Task', const AddTaskPage()),
          _nav(context, Icons.event_available, 'Leave Application',
              const LeaveApplicationPage()),
          _nav(context, Icons.list_alt, 'Leave Status', LeaveStatusPage()),
          _nav(context, Icons.bar_chart, 'Timesheet Review',
              const TimesheetReviewPage()),
          _nav(context, Icons.settings, 'Settings', const SettingsPage()),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  ListTile _nav(
      BuildContext context, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'dashboardpage_employee.dart';
// import 'calendartimesheetpage.dart';
// import 'projecttaskmanagement.dart';
// import 'add_task_page.dart';
import 'leave_application_page.dart';
// import 'leave_status_page.dart';
import 'settings_page.dart';
// import 'timesheet_approval.dart';
import '../login_page.dart';

class EmployeeAppDrawer extends StatelessWidget {
  const EmployeeAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF5B41F5)),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _navTile(context, Icons.timer, 'Time Tracker', DashboardPage()),
          // Hidden pages removed from menu
          _navTile(context, Icons.event_available, 'Leave Application',
              LeaveApplicationPage()),
          // _navTile(context, Icons.list_alt, 'Leave Status', LeaveStatusPage()),
          // _navTile(context, Icons.bar_chart, 'All Reports', TimesheetReviewPage()),
          _navTile(context, Icons.settings, 'Settings', SettingsPage()),
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

  ListTile _navTile(
      BuildContext context, IconData icon, String title, Widget target) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => target));
      },
    );
  }
}

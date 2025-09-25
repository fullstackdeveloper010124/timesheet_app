import 'package:flutter/material.dart';

class TimesheetReviewPage extends StatelessWidget {
  const TimesheetReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approval Workflow'),
        backgroundColor: const Color(0xFF1976D2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Timesheet Submission',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Submission'),
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF1976D2),
                    child: Icon(Icons.check, color: Colors.white, size: 18),
                  ),
                  SizedBox(width: 16),
                  Text('Review'),
                  SizedBox(width: 16),
                  Text('Approval'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Timesheet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildTimesheetRow('Apr 18', '8.0 hrs'),
                  _buildTimesheetRow('Apr 19', '8.0 hrs'),
                  _buildTimesheetRow('Apr 20', '4.0 hrs'),
                  _buildTimesheetRowWithStatus('Apr 21', 'REJECTED'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    side: const BorderSide(color: Color(0xFF1976D2)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'REJECT',
                    style: TextStyle(color: Color(0xFF1976D2)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('APPROVE'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Manager Feedback',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                'You did not work the minimum required hours on April 20.',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimesheetRow(String date, String hours) {
    return ListTile(
      title: Text(date),
      trailing: Text(hours),
    );
  }

  Widget _buildTimesheetRowWithStatus(String date, String status) {
    return ListTile(
      title: Text(date),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5D0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: const TextStyle(
            color: Color(0xFFB45100),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

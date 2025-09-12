import 'package:flutter/material.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  String? leaveType;
  String? leavePeriod;
  String? coveredBy;
  DateTime? selectedDate;
  TextEditingController reasonController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Leave'),
        backgroundColor: Color(0xFF5F4BD8),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF5F4BD8)),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // close drawer
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Apply Leave'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/applyLeave');
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Leave Status'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/leaveStatus');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Leave Application Form', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Please provide information about your leave.'),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Leave Type'),
              value: leaveType,
              items: ['Sick Leave', 'Casual Leave', 'Earned Leave']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => leaveType = val),
            ),
            SizedBox(height: 16),

            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(labelText: 'Select Date'),
                child: Text(selectedDate != null
                    ? "${selectedDate!.toLocal()}".split(' ')[0]
                    : 'Select leave date'),
              ),
            ),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Period'),
              value: leavePeriod,
              items: ['Full Day', 'Half Day - Morning', 'Half Day - Afternoon']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => leavePeriod = val),
            ),
            SizedBox(height: 16),

            TextFormField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Reason',
                hintText: 'Enter reason...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'No file chosen',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: Text("Upload")),
              ],
            ),
            SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Jobs Will Be Covered By'),
              value: coveredBy,
              items: ['John Doe', 'Jane Smith', 'No One']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => coveredBy = val),
            ),
            SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // Handle apply leave logic
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: const Color(0xFF5F4BD8),
              ),
              child: const Text(
                'Apply Leave',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

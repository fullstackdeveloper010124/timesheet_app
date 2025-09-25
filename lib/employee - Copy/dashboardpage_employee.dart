import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'projecttaskmanagement.dart';
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
    const TimeTrackerPage(),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), label: 'Timesheet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Apply Leave'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class TimeTrackerPage extends StatefulWidget {
  const TimeTrackerPage({super.key});

  @override
  State<TimeTrackerPage> createState() => _TimeTrackerPageState();
}

class _TimeTrackerPageState extends State<TimeTrackerPage> {
  bool manualEntry = false;
  bool billable = false;
  String? selectedProject;
  String? selectedTask;
  DateTime? entryDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Duration? get computedDuration {
    if (startTime == null || endTime == null) return null;
    final start = DateTime(0, 1, 1, startTime!.hour, startTime!.minute);
    final end = DateTime(0, 1, 1, endTime!.hour, endTime!.minute);
    final diff = end.difference(start);
    if (diff.isNegative) return null;
    return diff;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = entryDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) setState(() => entryDate = picked);
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => endTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time Tracker',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text('Manual Entry'),
                    const SizedBox(width: 8),
                    Checkbox(
                      value: manualEntry,
                      onChanged: (v) =>
                          setState(() => manualEntry = v ?? false),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Shift chip example
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9ECFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Weekly',
                  style: TextStyle(
                      color: Color(0xFF5B41F5), fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Track time by the week – for long-running tasks',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Your assigned shift: Weekly',
                style: TextStyle(
                    color: Color(0xFF3B5CCC), fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 24),

            // Live timer UI (hidden in manual entry)
            if (!manualEntry) ...[
              const Center(
                child: Text(
                  '00:00:00',
                  style: TextStyle(
                    fontSize: 48,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 220,
                  height: 56,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow, color: Colors.white),
                    label: const Text('Start',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
            ],

            // Manual entry fields
            if (manualEntry) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _OutlinedPicker(
                      label: 'Date *',
                      value: entryDate == null
                          ? 'Select date'
                          : '${entryDate!.year}-${entryDate!.month.toString().padLeft(2, '0')}-${entryDate!.day.toString().padLeft(2, '0')}',
                      onTap: _pickDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _OutlinedPicker(
                      label: 'Start time *',
                      value: startTime == null
                          ? 'Select start'
                          : startTime!.format(context),
                      onTap: _pickStartTime,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _OutlinedPicker(
                      label: 'End time *',
                      value: endTime == null
                          ? 'Select end'
                          : endTime!.format(context),
                      onTap: _pickEndTime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (computedDuration != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Duration: ${computedDuration!.inHours.toString().padLeft(2, '0')}:${(computedDuration!.inMinutes % 60).toString().padLeft(2, '0')} hrs',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: (entryDate != null &&
                          startTime != null &&
                          endTime != null &&
                          computedDuration != null)
                      ? () {}
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B41F5),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Save Entry',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Project dropdown
            const Text('Project *',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedProject,
                  hint: const Text('Select project'),
                  items: const [
                    DropdownMenuItem(value: 'p1', child: Text('Project A')),
                    DropdownMenuItem(value: 'p2', child: Text('Project B')),
                  ],
                  onChanged: (v) => setState(() {
                    selectedProject = v;
                    selectedTask = null;
                  }),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Task dropdown
            const Text('Task *', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTask,
                  hint: Text(selectedProject == null
                      ? 'Select a project first'
                      : 'Select task'),
                  items: selectedProject == null
                      ? const []
                      : const [
                          DropdownMenuItem(value: 't1', child: Text('Design')),
                          DropdownMenuItem(
                              value: 't2', child: Text('Development')),
                        ],
                  onChanged: selectedProject == null
                      ? null
                      : (v) => setState(() => selectedTask = v),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text('Description',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'What are you working on?',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Text('Billable'),
                const SizedBox(width: 8),
                Checkbox(
                  value: billable,
                  onChanged: (v) => setState(() => billable = v ?? false),
                ),
              ],
            ),
          ],
        ),
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

class _OutlinedPicker extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _OutlinedPicker({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

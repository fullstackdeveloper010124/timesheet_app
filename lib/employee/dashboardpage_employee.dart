import 'package:flutter/material.dart';
import 'leave_application_page.dart';
import 'timesheet_approval.dart';
import '../login_page.dart';
import 'app_drawer.dart';

void main() {
  runApp(const MaterialApp(home: DashboardPage()));
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Time Tracker'),
        backgroundColor: const Color(0xFF5B41F5),
      ),
      drawer: const EmployeeAppDrawer(),
      body: const TimeTrackerPage(),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TimesheetReviewPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bar_chart),
                  label: const Text('All Reports'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LeaveApplicationPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.event_available),
                  label: const Text('Leave Application'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5B41F5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
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

            // Project and Task dropdowns in one row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              DropdownMenuItem(
                                  value: 'p1', child: Text('Project A')),
                              DropdownMenuItem(
                                  value: 'p2', child: Text('Project B')),
                            ],
                            onChanged: (v) => setState(() {
                              selectedProject = v;
                              selectedTask = null;
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Task *',
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
                            value: selectedTask,
                            hint: Text(selectedProject == null
                                ? 'Select a project first'
                                : 'Select task'),
                            items: selectedProject == null
                                ? const []
                                : const [
                                    DropdownMenuItem(
                                        value: 't1', child: Text('Design')),
                                    DropdownMenuItem(
                                        value: 't2',
                                        child: Text('Development')),
                                  ],
                            onChanged: selectedProject == null
                                ? null
                                : (v) => setState(() => selectedTask = v),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

// Dashboard-only content removed. The employee dashboard now shows only the
// time tracker screen below.

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

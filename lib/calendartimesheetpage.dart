import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CalendarTimesheetPage()));
}

class CalendarTimesheetPage extends StatelessWidget {
  const CalendarTimesheetPage({super.key});

  static const Color primaryColor = Color(0xFF5B41F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar & Timesheet'),
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // Toggle Buttons (Calendar / Timesheet)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _toggleButton('Calendar', false),
              const SizedBox(width: 10),
              _toggleButton('Timesheet', true),
            ],
          ),

          const SizedBox(height: 12),

          // View Options (Daily / Weekly / Monthly)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _viewModeButton('Hourly', false),
              _viewModeButton('Daily', false),
              _viewModeButton('Weekly', true),
              _viewModeButton('Monthly', false),
            ],
          ),

          const SizedBox(height: 12),

          // Day Row
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _dayCircle('S', '21', false),
                _dayCircle('M', '22', false),
                _dayCircle('T', '23', false),
                _dayCircle('W', '24', true),
                _dayCircle('T', '25', false),
                _dayCircle('F', '26', false),
                _dayCircle('S', '27', false),
              ],
            ),
          ),

          const Divider(thickness: 1),

          // Calendar Grid
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                columnWidths: const {
                  0: FixedColumnWidth(60), // Time column
                },
                border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.grey.shade300)),
                children: _buildCalendarRows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleButton(String text, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
            color: selected ? Colors.white : primaryColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _viewModeButton(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: selected ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: primaryColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
            color: selected ? Colors.white : primaryColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _dayCircle(String day, String date, bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(day,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? primaryColor : Colors.transparent,
            ),
            child: Text(
              date,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  List<TableRow> _buildCalendarRows() {
    final List<String> times = [
      '8:00',
      '9:00',
      '10:00',
      '11:00',
      '12:00',
      '1:00',
      '2:00',
      '3:00',
      '4:00',
    ];

    final Map<String, Map<String, String>> schedule = {
      'Mo': {
        '9:00': 'Design Mockups',
        '5:00': 'Team Meeting',
      },
      'Tu': {
        '10:00': 'Client Call',
      },
      'We': {
        '11:00': 'Testing',
      },
      'Th': {
        '4:00': 'Documentation',
        '4:30': 'Code Review',
      },
      'Fr': {},
    };

    return List.generate(times.length, (index) {
      final time = times[index];
      return TableRow(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(time,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        ...['Mo', 'Tu', 'We', 'Th', 'Fr'].map((day) {
          final task = schedule[day]?[time];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: task != null
                ? _taskBlock('$task\n$time', primaryColor, 1)
                : const SizedBox(height: 40),
          );
        }).toList(),
      ]);
    });
  }

  Widget _taskBlock(String label, Color color, int lines) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LeaveStatusPage extends StatelessWidget {
  final recentLeave = {
    "title": "Annual Leave",
    "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
    "description": "Lorem ipsum napptemornter resskde när dekalälking kötos...",
    "status": "Pending"
  };

  final pastLeaves = [
    {
      "title": "Annual Leave",
      "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
      "description": "Lorem ipsum neblödgt benyblö dlgögt röm ot. Peqlüg vabonet.",
      "status": "Approved"
    },
    {
      "title": "Medical Leave",
      "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
      "description": "Lorem ipsum neblödgt benyblö dlgögt röm ot. Peqlüg vabonet.",
      "status": "Approved"
    },
    {
      "title": "Annual Leave",
      "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
      "description": "Lorem ipsum neblödgt benyblö dlgögt röm ot. Peqlüg vabonet.",
      "status": "Rejected"
    },
    {
      "title": "Annual Leave",
      "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
      "description": "Lorem ipsum neblödgt benyblö dlgögt röm ot. Peqlüg vabonet.",
      "status": "Approved"
    },
    {
      "title": "Medical Leave",
      "date": "1 Sep 2023 - 1 Sep 2023 (full day)",
      "description": "Lorem ipsum neblödgt benyblö dlgögt röm ot. Peqlüg vabonet.",
      "status": "Approved"
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Status'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Recent Application:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          LeaveCard(
            title: recentLeave["title"]!,
            date: recentLeave["date"]!,
            description: recentLeave["description"]!,
            status: recentLeave["status"]!,
            color: getStatusColor(recentLeave["status"]!),
          ),
          SizedBox(height: 16),
          Text('Past Application:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...pastLeaves.map((leave) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LeaveCard(
                  title: leave["title"]!,
                  date: leave["date"]!,
                  description: leave["description"]!,
                  status: leave["status"]!,
                  color: getStatusColor(leave["status"]!),
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Apply Leave'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Leave Status'),
        ],
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String status;
  final Color color;

  const LeaveCard({
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(date, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
            SizedBox(height: 6),
            Text(description, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

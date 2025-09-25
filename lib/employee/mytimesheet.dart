import 'package:flutter/material.dart';
import 'app_drawer.dart';

class MyTimesheetPage extends StatelessWidget {
  const MyTimesheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      appBar: AppBar(
        title: const Text('My Timesheets'),
        backgroundColor: const Color(0xFF5F4BD8),
      ),
      drawer: const EmployeeAppDrawer(),
      body: Stack(
        children: [
          // Background images
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/right.png', width: 150),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/left.png', width: 150),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu),
                      Text(
                        "My Timesheets",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          SizedBox(width: 5),
                          Text(
                            "Save",
                            style: TextStyle(
                                color: Color(0xFF5F4BD8),
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // View toggles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTab("Day", true),
                      _buildTab("Week", false),
                      _buildTab("Month", false),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Date navigation
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_left),
                      SizedBox(width: 8),
                      Text("26 October",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Pending/Completed toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTab("Pending", true),
                      _buildTab("Completed", false),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Task list header
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Task List"),
                      Row(
                        children: [
                          Icon(Icons.add_circle_outline,
                              color: Color(0xFF5F4BD8)),
                          SizedBox(width: 10),
                          Text(
                            "0 hrs /day",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Task card
                  _buildTaskCard("Cooking & helping head chef"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: isSelected ? const Color(0xFF5F4BD8) : Colors.black54,
        decoration: isSelected ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  Widget _buildTaskCard(String taskName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFCEDCFA),
            child: Text("C", style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              taskName,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 60,
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text("hh:mm", style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

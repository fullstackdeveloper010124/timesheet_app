import 'package:flutter/material.dart';
import 'app_drawer.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String? selectedTask;
  final List<String> taskOptions = [
    'Design',
    'Development',
    'Testing',
    'Meeting'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: const Color(0xFF5F4BD8),
      ),
      drawer: const EmployeeAppDrawer(),
      body: Stack(
        children: [
          // Top Right Background Image
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/right.png',
              width: 150,
            ),
          ),

          // Bottom Left Background Image
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/left.png',
              width: 150,
            ),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Add New Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Task Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Select task'),
                      value: selectedTask,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (value) {
                        setState(() {
                          selectedTask = value;
                        });
                      },
                      items: taskOptions.map((task) {
                        return DropdownMenuItem<String>(
                          value: task,
                          child: Text(task),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

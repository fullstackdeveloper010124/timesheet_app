import 'package:flutter/material.dart';
import 'app_drawer.dart';

void main() {
  runApp(const MaterialApp(home: ProjectTaskManagementPage()));
}

class ProjectTaskManagementPage extends StatelessWidget {
  const ProjectTaskManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6A48D7),
        title: const Text(
          'Project & Task Management',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const EmployeeAppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create, assign, and categorize tasks.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Task',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    // Title
                    const Text('Title'),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Prepare presentation',
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description
                    const Text('Description'),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Slides',
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Project
                    const Text('Project'),
                    DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                            value: 'website', child: Text('Website Redesign')),
                      ],
                      onChanged: (_) {},
                      decoration: const InputDecoration(),
                    ),
                    const SizedBox(height: 12),

                    // Assignee
                    const Text('Assignee'),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?img=3'), // Placeholder avatar
                          radius: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text('David'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Create Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Create task action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('CREATE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Time Entry Section
            const Text(
              'Associate time entries with projects or clients.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: ListTile(
                title: const Text('10:30 AM – 12:00 PM'),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Development'),
                    Text('Mobile App'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.access_time), label: 'Timesheet'),
      //     BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      // ),
    );
  }
}

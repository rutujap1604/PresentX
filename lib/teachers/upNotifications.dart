import 'package:flutter/material.dart';

class UploadNotificationsPage extends StatefulWidget {
  const UploadNotificationsPage({super.key});

  @override
  State<UploadNotificationsPage> createState() =>
      _UploadNotificationsPageState();
}

class _UploadNotificationsPageState extends State<UploadNotificationsPage> {
  String? selectedYear = 'TY';
  String? selectedDepartment = 'CSE';
  final List<String> yearList = ['SY', 'TY', 'B.Tech'];
  final List<String> departmentList = ['CSE', 'AIDS'];
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isUploading = false;
  
  // Mock data for notifications
  final List<Map<String, dynamic>> mockNotifications = [
    {
      'id': '1',
      'title': 'Internal Exam Scheduled',
      'description': 'Mid-semester exams starting from next week. Check the timetable.',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'title': 'Guest Lecture',
      'description': 'Expert session on Cloud Computing at 10 AM tomorrow in Hall A.',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 5)),
    },
  ];

  void uploadNotification() async {
    if (titleController.text.trim().isEmpty || descController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }
    setState(() => isUploading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isUploading = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Notification posted successfully (Demo).'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                titleController.clear();
                descController.clear();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Notification', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedYear,
                    items: yearList.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                    onChanged: (val) => setState(() => selectedYear = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Year'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedDepartment,
                    items: departmentList.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (val) => setState(() => selectedDepartment = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Dept'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadNotification,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Post Notification'),
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Posted Notifications:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            ...mockNotifications.map((data) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(data['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['description']),
                    Text(
                      'Posted: ${data['uploadedAt'].toString().substring(0, 16)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.delete, color: Colors.grey),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

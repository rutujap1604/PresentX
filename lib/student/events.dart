import 'package:flutter/material.dart';

class StudentNotificationsPage extends StatelessWidget {
  const StudentNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock notifications for demo
    final List<Map<String, dynamic>> mockNotifications = [
      {
        'title': 'Guest Lecture on AI',
        'description': 'Don\'t miss the guest lecture by Dr. Smith on Tuesday at 10 AM in the Seminar Hall.',
        'uploadedAt': DateTime.now().subtract(const Duration(hours: 2)),
      },
      {
        'title': 'Hackathon Registration Open',
        'description': 'Register now for the 24-hour coding challenge. Great prizes await!',
        'uploadedAt': DateTime.now().subtract(const Duration(days: 1)),
      },
      {
        'title': 'Mid-Term Exam Schedule',
        'description': 'The schedule for the mid-term exams has been uploaded to the notice board.',
        'uploadedAt': DateTime.now().subtract(const Duration(days: 3)),
      },
      {
        'title': 'Holiday Notice',
        'description': 'College will remain closed this Friday on account of the festival.',
        'uploadedAt': DateTime.now().subtract(const Duration(days: 5)),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        itemCount: mockNotifications.length,
        itemBuilder: (context, idx) {
          final data = mockNotifications[idx];
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: ListTile(
              title: Text(data['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(data['description'] ?? ''),
                  const SizedBox(height: 8),
                  Text(
                    'Posted: ${data['uploadedAt'].toString().substring(0, 16)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

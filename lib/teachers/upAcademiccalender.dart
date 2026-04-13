import 'package:flutter/material.dart';

class UploadAcademicCalendarPage extends StatefulWidget {
  const UploadAcademicCalendarPage({super.key});

  @override
  State<UploadAcademicCalendarPage> createState() =>
      _UploadAcademicCalendarPageState();
}

class _UploadAcademicCalendarPageState
    extends State<UploadAcademicCalendarPage> {
  String? selectedClass = 'TY';
  final List<String> classList = ['SY', 'TY', 'B.Tech'];
  final descController = TextEditingController();
  List<String> pickedFiles = [];
  bool isUploading = false;
  
  // Mock data
  final List<Map<String, dynamic>> mockUploaded = [
    {
      'id': '1',
      'description': 'Academic Calendar 2024-25 Semester 6',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 20)),
    }
  ];

  void pickFiles() {
    setState(() {
      pickedFiles = ['academic_calendar_2024_25.pdf'];
    });
  }

  void uploadCalendar() async {
    if (selectedClass == null || pickedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select class and files.')),
      );
      return;
    }
    setState(() => isUploading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isUploading = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Academic Calendar uploaded successfully (Demo).'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                pickedFiles = [];
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
        title: const Text('Academic Calendar', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedClass,
              hint: const Text('Select Class'),
              items: classList.map((cls) => DropdownMenuItem(value: cls, child: Text(cls))).toList(),
              onChanged: (val) => setState(() => selectedClass = val),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Class'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: pickFiles,
              icon: const Icon(Icons.attach_file),
              label: const Text('Pick Calendar Files (PDF/Images)'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50], foregroundColor: Colors.blue),
            ),
            if (pickedFiles.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                children: pickedFiles.map((file) => Chip(label: Text(file))).toList(),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadCalendar,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Academic Calendar'),
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Previous Uploads:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            ...mockUploaded.map((data) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.event_note, color: Colors.blue),
                title: Text(data['description']),
                subtitle: Text("Uploaded: ${data['uploadedAt'].toString().substring(0, 16)}"),
                trailing: const Icon(Icons.delete, color: Colors.grey),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

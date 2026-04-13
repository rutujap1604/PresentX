import 'package:flutter/material.dart';

class UploadTimetablePage extends StatefulWidget {
  const UploadTimetablePage({super.key});

  @override
  State<UploadTimetablePage> createState() => _UploadTimetablePageState();
}

class _UploadTimetablePageState extends State<UploadTimetablePage> {
  String? selectedClass = 'TY';
  final List<String> classList = ['SY', 'TY', 'B.Tech'];
  final descController = TextEditingController();
  List<String> pickedFiles = [];
  bool isUploading = false;
  
  // Mock data
  final List<Map<String, dynamic>> mockUploaded = [
    {
      'id': '1',
      'description': 'TY CSE Semester 6 Timetable',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 5)),
    }
  ];

  void pickFiles() {
    setState(() {
      pickedFiles = ['timetable_ty_cse.jpg'];
    });
  }

  void uploadTimetable() async {
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
        content: const Text('Timetable uploaded successfully (Demo).'),
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
        title: const Text('Upload Timetable', style: TextStyle(color: Colors.white)),
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
              label: const Text('Pick Timetable Files (PDF/Images)'),
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
                onPressed: isUploading ? null : uploadTimetable,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Timetable'),
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
                leading: const Icon(Icons.calendar_today, color: Colors.blue),
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

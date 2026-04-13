import 'package:flutter/material.dart';

class UploadSyllabusPage extends StatefulWidget {
  const UploadSyllabusPage({super.key});

  @override
  State<UploadSyllabusPage> createState() => _UploadSyllabusPageState();
}

class _UploadSyllabusPageState extends State<UploadSyllabusPage> {
  String? selectedYear = 'TY';
  String? teacherDepartment = 'CSE';
  final List<String> yearList = ['SY', 'TY', 'B.Tech'];
  final descController = TextEditingController();
  List<String> pickedFiles = [];
  bool isUploading = false;
  
  // Mock previous uploads
  final List<Map<String, dynamic>> mockUploaded = [
    {
      'id': '1',
      'description': 'TY CSE Semester 5 Syllabus',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 12)),
    }
  ];

  void pickFiles() {
    setState(() {
      pickedFiles = ['syllabus_final_v2.pdf'];
    });
  }

  void uploadSyllabus() async {
    if (selectedYear == null || pickedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select year and files.')),
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
        content: const Text('Syllabus uploaded successfully (Demo).'),
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
        title: const Text('Upload Syllabus', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              initialValue: selectedYear,
              hint: const Text('Select Year'),
              items: yearList.map((year) => DropdownMenuItem(value: year, child: Text(year))).toList(),
              onChanged: (val) => setState(() => selectedYear = val),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Year'),
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
              label: const Text('Pick Syllabus Files (PDF/Images)'),
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
                onPressed: isUploading ? null : uploadSyllabus,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Syllabus'),
              ),
            ),
            const SizedBox(height: 32),
            const Text("Previous Uploads:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ...mockUploaded.map((data) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.description, color: Colors.blue),
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

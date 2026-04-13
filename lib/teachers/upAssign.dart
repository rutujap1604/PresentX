import 'package:flutter/material.dart';

class UploadAssignmentPage extends StatefulWidget {
  const UploadAssignmentPage({super.key});

  @override
  State<UploadAssignmentPage> createState() => _UploadAssignmentPageState();
}

class _UploadAssignmentPageState extends State<UploadAssignmentPage> {
  String? selectedClass = 'TY';
  String? teacherDepartment = 'CSE';
  final titleController = TextEditingController();
  final descController = TextEditingController();
  String? fileName;
  bool isUploading = false;

  final List<String> classList = ['SY', 'TY', 'B.Tech'];
  
  // Mock data for currently uploaded assignments
  final List<Map<String, dynamic>> mockUploaded = [
    {
      'id': '1',
      'title': 'Data Structures Lab 1',
      'description': 'Linked List Implementation',
      'type': 'pdf',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '2',
      'title': 'Hashing Assignment',
      'description': 'Solve the exercise from the textbook.',
      'type': 'image',
      'uploadedAt': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  void pickFile() {
    setState(() {
      fileName = "demo_assignment_file.pdf";
    });
  }

  void uploadAssignment() async {
    if (titleController.text.isEmpty || fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and select a file.')),
      );
      return;
    }

    setState(() => isUploading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate upload
    setState(() => isUploading = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Assignment uploaded successfully (Demo).'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                fileName = null;
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
        title: const Text('Upload Assignment'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Assignment Title',
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
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Choose File'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50], foregroundColor: Colors.blue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    fileName ?? 'No file selected',
                    style: TextStyle(color: fileName == null ? Colors.grey : Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isUploading ? null : uploadAssignment,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload Assignment'),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Previous Uploads:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...mockUploaded.map((data) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(
                  data['type'] == 'pdf' ? Icons.picture_as_pdf : Icons.image,
                  color: data['type'] == 'pdf' ? Colors.red : Colors.green,
                ),
                title: Text(data['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("${data['description']}\nUploaded: ${data['uploadedAt'].toString().substring(0, 16)}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () {},
                ),
                isThreeLine: true,
              ),
            )),
          ],
        ),
      ),
    );
  }
}

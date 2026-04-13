import 'package:flutter/material.dart';

class UploadMarksPage extends StatefulWidget {
  const UploadMarksPage({super.key});

  @override
  State<UploadMarksPage> createState() => _UploadMarksPageState();
}

class _UploadMarksPageState extends State<UploadMarksPage> {
  String? selectedClass = 'TY';
  String? selectedExam = 'Mid sem';
  String? selectedSubject = 'Data Structures';
  
  final List<String> classList = ['SY', 'TY', 'B.Tech'];
  final List<String> examTypes = ['CA1', 'Mid sem', 'CA2'];
  final List<String> subjectList = ['Mathematics III', 'Data Structures', 'Operating Systems', 'DBMS'];
  
  List<Map<String, dynamic>> students = [
    {'name': 'Rahul Sharma', 'prn': '2021BCS001'},
    {'name': 'Anita Patil', 'prn': '2021BCS012'},
    {'name': 'Sumeet Verma', 'prn': '2021BCS025'},
    {'name': 'Priya Dhar', 'prn': '2021BCS038'},
  ];
  
  Map<String, TextEditingController> marksControllers = {};
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    for (var student in students) {
      marksControllers[student['prn']] = TextEditingController(text: '25');
    }
  }

  void uploadMarks() async {
    setState(() => isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isSaving = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Marks saved successfully (Demo).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
        title: const Text('Upload Marks', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedClass,
                    items: classList.map((cls) => DropdownMenuItem(value: cls, child: Text(cls))).toList(),
                    onChanged: (val) => setState(() => selectedClass = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Class'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedExam,
                    items: examTypes.map((exam) => DropdownMenuItem(value: exam, child: Text(exam))).toList(),
                    onChanged: (val) => setState(() => selectedExam = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Exam'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedSubject,
              items: subjectList.map((sub) => DropdownMenuItem(value: sub, child: Text(sub))).toList(),
              onChanged: (val) => setState(() => selectedSubject = val),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Subject'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, idx) {
                  final student = students[idx];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(student['name']),
                      subtitle: Text('PRN: ${student['prn']}'),
                      trailing: SizedBox(
                        width: 100,
                        child: TextField(
                          controller: marksControllers[student['prn']],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Marks',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isSaving ? null : uploadMarks,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save Marks', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

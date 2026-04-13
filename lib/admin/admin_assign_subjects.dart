import 'package:flutter/material.dart';

class AdminAssignSubjectsPage extends StatefulWidget {
  const AdminAssignSubjectsPage({super.key});

  @override
  State<AdminAssignSubjectsPage> createState() =>
      _AdminAssignSubjectsPageState();
}

class _AdminAssignSubjectsPageState extends State<AdminAssignSubjectsPage> {
  String? selectedTeacherId;
  String? selectedDepartment = 'All';
  String? selectedSemester = 'All';
  String? selectedClass = 'All';
  List<String> selectedSubjectIds = [];

  final List<String> departments = ['All', 'CSE', 'AIDS'];
  final List<String> semesters = ['All', '1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> classes = ['All', 'SY', 'TY', 'BTech'];

  // Mock data
  final List<Map<String, dynamic>> mockTeachers = [
    {'id': 't1', 'name': 'Dr. Amit Sharma'},
    {'id': 't2', 'name': 'Prof. Priya Patil'},
  ];

  final List<Map<String, dynamic>> mockSubjects = [
    {'id': 's1', 'subjectName': 'Mathematics III', 'department': 'CSE', 'semester': '3', 'class': 'SY'},
    {'id': 's2', 'subjectName': 'Data Structures', 'department': 'CSE', 'semester': '3', 'class': 'SY'},
    {'id': 's3', 'subjectName': 'Operating Systems', 'department': 'CSE', 'semester': '5', 'class': 'TY'},
  ];

  List<Map<String, dynamic>> assignments = [
    {
      'id': 'a1',
      'teacherName': 'Dr. Amit Sharma',
      'subjectName': 'Data Structures',
      'department': 'CSE',
      'semester': '3',
      'class': 'SY'
    }
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSubjects = mockSubjects.where((s) {
      bool matchDept = selectedDepartment == 'All' || s['department'] == selectedDepartment;
      bool matchSem = selectedSemester == 'All' || s['semester'] == selectedSemester;
      bool matchClass = selectedClass == 'All' || s['class'] == selectedClass;
      return matchDept && matchSem && matchClass;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Subjects'),
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: selectedTeacherId,
                      hint: const Text('Select Teacher'),
                      items: mockTeachers.map((t) => DropdownMenuItem(value: t['id'] as String, child: Text(t['name']))).toList(),
                      onChanged: (val) => setState(() => selectedTeacherId = val),
                      decoration: const InputDecoration(labelText: 'Teacher', border: OutlineInputBorder(), isDense: true),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildSmallDrop('Dept', selectedDepartment!, departments, (v) => setState(() => selectedDepartment = v))),
                        const SizedBox(width: 8),
                        Expanded(child: _buildSmallDrop('Sem', selectedSemester!, semesters, (v) => setState(() => selectedSemester = v))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Select Subjects:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: filteredSubjects.length,
                itemBuilder: (context, idx) {
                  final s = filteredSubjects[idx];
                  final isSelected = selectedSubjectIds.contains(s['id']);
                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (val) {
                      setState(() {
                        if (val == true) {
                          selectedSubjectIds.add(s['id']);
                        } else {
                          selectedSubjectIds.remove(s['id']);
                        }
                      });
                    },
                    title: Text(s['subjectName']),
                    subtitle: Text('${s['department']} | Sem ${s['semester']} | ${s['class']}'),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTeacherId != null && selectedSubjectIds.isNotEmpty
                    ? () {
                        setState(() {
                          final teacher = mockTeachers.firstWhere((t) => t['id'] == selectedTeacherId);
                          for (var sid in selectedSubjectIds) {
                            final sub = mockSubjects.firstWhere((s) => s['id'] == sid);
                            assignments.add({
                              'id': DateTime.now().toString(),
                              'teacherName': teacher['name'],
                              'subjectName': sub['subjectName'],
                              'department': sub['department'],
                              'semester': sub['semester'],
                              'class': sub['class'],
                            });
                          }
                          selectedSubjectIds.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subjects assigned! (Demo)')));
                      }
                    : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], foregroundColor: Colors.white),
                child: const Text('Assign Selected'),
              ),
            ),
            const Divider(height: 32),
            const Text("Current Assignments:", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, idx) {
                  final a = assignments[idx];
                  return Card(
                    child: ListTile(
                      title: Text(a['subjectName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Teacher: ${a['teacherName']}\n${a['department']} | Sem ${a['semester']} | ${a['class']}'),
                      trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.grey), onPressed: () {
                        setState(() => assignments.removeAt(idx));
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallDrop(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12)))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), isDense: true),
    );
  }
}

import 'package:flutter/material.dart';

class AdminSubjectsPage extends StatefulWidget {
  const AdminSubjectsPage({super.key});

  @override
  State<AdminSubjectsPage> createState() => _AdminSubjectsPageState();
}

class _AdminSubjectsPageState extends State<AdminSubjectsPage> {
  final _subjectController = TextEditingController();

  final List<String> departments = ['All', 'CSE', 'AIDS'];
  final List<String> semesters = ['All', '1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> classes = ['All', 'FY', 'SY', 'TY', 'BTech'];

  String selectedDepartment = 'All';
  String selectedSemester = 'All';
  String selectedClass = 'All';

  // Mock data for subjects
  final List<Map<String, dynamic>> mockSubjects = [
    {'id': 's1', 'subjectName': 'Mathematics III', 'department': 'CSE', 'semester': '3', 'class': 'SY'},
    {'id': 's2', 'subjectName': 'Data Structures', 'department': 'CSE', 'semester': '3', 'class': 'SY'},
    {'id': 's3', 'subjectName': 'Operating Systems', 'department': 'CSE', 'semester': '5', 'class': 'TY'},
    {'id': 's4', 'subjectName': 'Machine Learning', 'department': 'AIDS', 'semester': '5', 'class': 'TY'},
  ];

  late List<Map<String, dynamic>> subjects;

  @override
  void initState() {
    super.initState();
    subjects = List.from(mockSubjects);
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  void _addSubject() {
    final subjectName = _subjectController.text.trim();
    if (subjectName.isEmpty || selectedDepartment == 'All' || selectedSemester == 'All' || selectedClass == 'All') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all filters and enter subject name.')),
      );
      return;
    }
    setState(() {
      subjects.add({
        'id': DateTime.now().toString(),
        'department': selectedDepartment,
        'semester': selectedSemester,
        'class': selectedClass,
        'subjectName': subjectName,
      });
    });
    _subjectController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject added! (Demo)')));
  }

  void _deleteSubject(String id) {
    setState(() {
      subjects.removeWhere((s) => s['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject deleted! (Demo)')));
  }

  void _clearFilters() {
    setState(() {
      selectedDepartment = 'All';
      selectedSemester = 'All';
      selectedClass = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubjects = subjects.where((s) {
      bool matchDept = selectedDepartment == 'All' || s['department'] == selectedDepartment;
      bool matchSem = selectedSemester == 'All' || s['semester'] == selectedSemester;
      bool matchClass = selectedClass == 'All' || s['class'] == selectedClass;
      return matchDept && matchSem && matchClass;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subjects'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildDropdown('Dept', selectedDepartment, departments, (val) => setState(() => selectedDepartment = val!)),
                _buildDropdown('Sem', selectedSemester, semesters, (val) => setState(() => selectedSemester = val!)),
                _buildDropdown('Class', selectedClass, classes, (val) => setState(() => selectedClass = val!)),
                IconButton(onPressed: _clearFilters, icon: const Icon(Icons.filter_alt_off), tooltip: 'Clear'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _subjectController,
                    decoration: const InputDecoration(labelText: 'Add New Subject', border: OutlineInputBorder(), isDense: true),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addSubject, child: const Text('Add')),
              ],
            ),
            const Divider(height: 32),
            Expanded(
              child: filteredSubjects.isEmpty
                  ? const Center(child: Text('No subjects found.'))
                  : ListView.builder(
                      itemCount: filteredSubjects.length,
                      itemBuilder: (context, idx) {
                        final s = filteredSubjects[idx];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(s['subjectName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Sem: ${s['semester']} | Class: ${s['class']} | Dept: ${s['department']}'),
                            trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.grey), onPressed: () => _deleteSubject(s['id'])),
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

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 100,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        items: items.map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12)))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(), isDense: true),
      ),
    );
  }
}

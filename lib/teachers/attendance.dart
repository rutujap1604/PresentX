import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String? selectedYear = 'TY';
  String? selectedDepartment = 'CSE';
  String? selectedSubject = 'Data Structures';
  
  final List<String> subjectList = ['Data Structures', 'Mathematics III', 'DBMS', 'Operating Systems'];
  final List<String> yearList = ['SY', 'TY', 'B.Tech'];
  final List<String> departmentList = ['CSE', 'AIDS'];
  
  Map<String, bool?> attendance = {};
  List<Map<String, dynamic>> students = [
    {'uid': '1', 'name': 'Rahul Sharma', 'prn': '2021BCS001'},
    {'uid': '2', 'name': 'Anita Patil', 'prn': '2021BCS012'},
    {'uid': '3', 'name': 'Sumeet Verma', 'prn': '2021BCS025'},
    {'uid': '4', 'name': 'Priya Dhar', 'prn': '2021BCS038'},
    {'uid': '5', 'name': 'John Doe', 'prn': '2021BCS045'},
    {'uid': '6', 'name': 'Jane Smith', 'prn': '2021BCS050'},
  ];
  
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() {
    attendance = {for (var s in students) s['uid'] as String: null};
  }

  void _setAttendance(String uid, bool isPresent) {
    setState(() {
      attendance[uid] = isPresent;
    });
  }

  void _submitAttendance() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Attendance for today has been recorded successfully (Demo).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentRow(Map<String, dynamic> s) {
    final uid = s['uid'] as String;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(s['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('PRN: ${s['prn']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: attendance[uid] == true,
                  onChanged: (val) => _setAttendance(uid, true),
                  activeColor: Colors.green,
                ),
                const Text('P', style: TextStyle(fontSize: 10)),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: attendance[uid] == false,
                  onChanged: (val) => _setAttendance(uid, false),
                  activeColor: Colors.red,
                ),
                const Text('A', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Attendance'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedYear,
                    hint: const Text('Year'),
                    items: yearList.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                    onChanged: (val) => setState(() => selectedYear = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Year'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedDepartment,
                    hint: const Text('Dept'),
                    items: departmentList.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                    onChanged: (val) => setState(() => selectedDepartment = val),
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Dept'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedSubject,
              hint: const Text('Select Subject'),
              items: subjectList.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => selectedSubject = val),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Subject'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Expanded(
              child: ListView(
                children: students.map(_buildStudentRow).toList(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitAttendance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Submit Attendance', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

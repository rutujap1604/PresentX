import 'package:flutter/material.dart';

class AdminTeachersPage extends StatefulWidget {
  const AdminTeachersPage({super.key});

  @override
  State<AdminTeachersPage> createState() => _AdminTeachersPageState();
}

class _AdminTeachersPageState extends State<AdminTeachersPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _deptController = TextEditingController();
  final _passwordController = TextEditingController();

  final List<String> departments = ['CSE', 'AIDS'];
  String? selectedDepartment;
  String? filterDepartment;

  // Mock data for teachers
  final List<Map<String, dynamic>> mockTeachers = [
    {
      'id': 't1',
      'name': 'Dr. Amit Sharma',
      'email': 'amit.sharma@college.edu',
      'department': 'CSE',
      'role': 'teacher',
    },
    {
      'id': 't2',
      'name': 'Prof. Priya Patil',
      'email': 'priya.patil@college.edu',
      'department': 'AIDS',
      'role': 'teacher',
    },
    {
      'id': 't3',
      'name': 'Dr. Sameer Verma',
      'email': 'sameer.verma@college.edu',
      'department': 'CSE',
      'role': 'teacher',
    },
  ];

  late List<Map<String, dynamic>> teachers;

  @override
  void initState() {
    super.initState();
    teachers = List.from(mockTeachers);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _deptController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _addTeacher() {
    if (!_formKey.currentState!.validate() || selectedDepartment == null) return;
    
    setState(() {
      teachers.add({
        'id': DateTime.now().toString(),
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'department': selectedDepartment,
        'role': 'teacher',
      });
    });

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Teacher added! (Demo)')));
  }

  void _deleteTeacher(String id) {
    setState(() {
      teachers.removeWhere((t) => t['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Teacher deleted! (Demo)')));
  }

  void _showAddTeacherDialog() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    selectedDepartment = null;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Teacher'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (v) => v == null || v.isEmpty ? 'Enter email' : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedDepartment,
                  decoration: const InputDecoration(labelText: 'Department'),
                  items: departments.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                  onChanged: (val) => setState(() => selectedDepartment = val),
                  validator: (v) => v == null ? 'Select department' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (v) => v == null || v.isEmpty ? 'Enter password' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: _addTeacher, child: const Text('Add')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTeachers = filterDepartment == null 
        ? teachers 
        : teachers.where((t) => t['department'] == filterDepartment).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Teachers'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTeacherDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Teacher'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Filter by Department:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: filterDepartment,
                  hint: const Text('All'),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('All')),
                    ...departments.map((d) => DropdownMenuItem(value: d, child: Text(d))),
                  ],
                  onChanged: (val) => setState(() => filterDepartment = val),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredTeachers.isEmpty
                  ? const Center(child: Text('No teachers found.'))
                  : ListView.builder(
                      itemCount: filteredTeachers.length,
                      itemBuilder: (context, idx) {
                        final data = filteredTeachers[idx];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const CircleAvatar(child: Icon(Icons.person)),
                            title: Text(data['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Email: ${data['email']}\nDept: ${data['department']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.grey),
                              onPressed: () => _deleteTeacher(data['id']),
                            ),
                            isThreeLine: true,
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
}

import 'package:flutter/material.dart';

class AttendanceStudent extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AttendanceStudent());
  const AttendanceStudent({super.key});

  @override
  State<AttendanceStudent> createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {
  // Mock attendance data for demo
  final List<Map<String, dynamic>> subjectAttendance = [
    {"subject": "Mathematics III", "percent": 82.0},
    {"subject": "Data Structures", "percent": 74.0},
    {"subject": "Operating Systems", "percent": 90.0},
    {"subject": "DBMS", "percent": 65.0},
    {"subject": "Computer Networks", "percent": 78.0},
  ];

  bool isLoading = false;

  Color getAttendanceColor(double attendance) {
    if (attendance >= 75) return const Color(0xFFD4EDDA); // Light green
    if (attendance >= 50) return Colors.yellow[200]!; // Light yellow
    return Colors.red[200]!; // Light red
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    double overall =
        subjectAttendance.isNotEmpty
            ? subjectAttendance
                    .map((e) => e['percent'] as double)
                    .reduce((a, b) => a + b) /
                subjectAttendance.length
            : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWide ? size.width * 0.15 : 16.0,
                        vertical: 24,
                      ),
                      child: Column(
                        children: [
                          // Overall Attendance Card
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: CircularProgressIndicator(
                                        value: overall / 100,
                                        backgroundColor: Colors.blue[100],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                        strokeWidth: 7,
                                      ),
                                    ),
                                    Text(
                                      "${overall.toStringAsFixed(0)}%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isWide ? 20 : 17,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  "Overall Attendance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: isWide ? 22 : 18,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Subject wise Attendance:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Responsive grid for subject attendance
                          Expanded(
                            child: GridView.builder(
                              itemCount: subjectAttendance.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isWide ? 3 : 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                final subject = subjectAttendance[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: getAttendanceColor(
                                      subject["percent"],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${subject["subject"]}: \n${subject["percent"].toInt()}%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: isWide ? 18 : 15,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

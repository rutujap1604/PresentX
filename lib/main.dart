import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:present_x/providers/auth_provider.dart';
import 'package:present_x/login_page.dart';
import 'package:present_x/signup.dart';
import 'package:present_x/student/home.dart';
import 'package:present_x/student/events.dart';
import 'package:present_x/student/marks.dart';
import 'package:present_x/teachers/homepage.dart';
import 'package:present_x/teachers/attendance.dart';
import 'package:present_x/teachers/upAcademiccalender.dart';
import 'package:present_x/teachers/upAssign.dart';
import 'package:present_x/teachers/upMarks.dart';
import 'package:present_x/teachers/upNotifications.dart';
import 'package:present_x/teachers/upSyllabus.dart';
import 'package:present_x/teachers/upTimetable.dart';
import 'package:present_x/admin/admin_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Present X',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        builder: (context, child) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(55),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFF1C1C1E), width: 3),
                  ),
                  child: SizedBox(
                    width: 400,
                    height: 850,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 38),
                              child: MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  size: const Size(400, 850),
                                ),
                                child: child!,
                              ),
                            ),
                          ),
                          // Mock Notch
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 150,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 60,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Mock Status Bar
                          Positioned(
                            top: 8,
                            left: 30,
                            right: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "9:41",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.signal_cellular_alt, size: 14, color: Colors.black),
                                    SizedBox(width: 4),
                                    Icon(Icons.wifi, size: 14, color: Colors.black),
                                    SizedBox(width: 4),
                                    Icon(Icons.battery_full, size: 14, color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Home Indicator
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                width: 130,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(2.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => Homeview(),
          '/teacherHome': (context) => const TeacherHomePage(),
          '/marks': (context) => const MarksPage(),
          '/attendance': (context) => const AttendancePage(),
          '/events': (context) => const StudentNotificationsPage(),
          '/uploadAssignment': (context) => const UploadAssignmentPage(),
          '/upMarks': (context) => const UploadMarksPage(),
          '/upTimetable': (context) => const UploadTimetablePage(),
          '/upSyllabus': (context) => const UploadSyllabusPage(),
          '/upAcademicCalender': (context) => const UploadAcademicCalendarPage(),
          '/upNotifications': (context) => const UploadNotificationsPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/attendance') {
            return MaterialPageRoute(builder: (context) => const AttendancePage());
          }
          return null;
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user == null) {
      return const SignUpPage();
    }

    if (authProvider.role == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (authProvider.role == 'admin') {
      return AdminHomePage();
    } else if (authProvider.role == 'teacher') {
      return const TeacherHomePage();
    } else {
      return Homeview();
    }
  }
}

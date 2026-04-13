import 'package:flutter/material.dart';

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({super.key});

  @override
  State<SyllabusPage> createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  // Mock syllabus data for demo
  final List<Map<String, dynamic>> mockSyllabus = [
    {
      'title': 'Computer Science TY Syllabus 2024-25',
      'description': 'Full syllabus for the final year Computer Science department.',
      'files': [
        'https://picsum.photos/400/600?random=11',
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'
      ],
      'uploadedAt': DateTime.now().subtract(const Duration(days: 10)),
    },
    {
      'title': 'Mathematics III Course Outline',
      'description': 'Specific topics covered in the Mathematics III course.',
      'files': [
        'https://picsum.photos/400/600?random=12',
      ],
      'uploadedAt': DateTime.now().subtract(const Duration(days: 15)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF42A5F5),
        elevation: 0,
        title: const Text('Syllabus', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: mockSyllabus.length,
          itemBuilder: (context, idx) {
            final data = mockSyllabus[idx];
            final files = List<String>.from(data['files'] ?? []);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'] ?? 'Syllabus',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(data['description'] ?? ''),
                    const SizedBox(height: 16),
                    ...files.map((url) {
                      bool isPdf = url.toLowerCase().contains('.pdf');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isPdf ? Colors.red[50] : Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isPdf ? Icons.picture_as_pdf : Icons.image,
                                  color: isPdf ? Colors.red : Colors.blue,
                                  size: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  isPdf ? "View PDF Document" : "View Image",
                                  style: TextStyle(
                                    color: isPdf ? Colors.red : Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Text(
                      'Uploaded: ${data['uploadedAt'].toString().substring(0, 16)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

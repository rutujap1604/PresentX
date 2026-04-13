import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AssignmentPage());
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  String searchQuery = "";
  
  // Mock assignments for demo
  final List<Map<String, dynamic>> mockAssignments = [
    {
      "title": "Data Structures Assignment 1",
      "description": "Implement a Singly Linked List with all basic operations.",
      "uploadedBy": "Prof. Sharma",
      "type": "image",
      "fileUrl": "https://picsum.photos/800/600?random=1",
      "uploadedAt": DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      "title": "Mathematics Quiz 2",
      "description": "Solve the attached PDF for Laplace Transforms.",
      "uploadedBy": "Dr. Patil",
      "type": "pdf",
      "fileUrl": "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
      "uploadedAt": DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      "title": "DBMS Lab Work",
      "description": "Create a schema for a Library Management System.",
      "uploadedBy": "Prof. Verma",
      "type": "image",
      "fileUrl": "https://picsum.photos/800/600?random=2",
      "uploadedAt": DateTime.now().subtract(const Duration(days: 7)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    final filteredAssignments = mockAssignments.where((assignment) {
      final query = searchQuery.toLowerCase();
      return assignment["title"].toLowerCase().contains(query) ||
          assignment["description"].toLowerCase().contains(query) ||
          (assignment["uploadedBy"] ?? "").toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Assignments",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWide ? size.width * 0.15 : 16.0,
              vertical: 20,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search assignments...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFFF2F4F8),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredAssignments.isEmpty
                      ? const Center(
                          child: Text(
                            "No assignments found.",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredAssignments.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 18),
                          itemBuilder: (context, index) {
                            final assignment = filteredAssignments[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 18,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    assignment["title"] ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900],
                                      fontSize: isWide ? 22 : 18,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    assignment["description"] ?? "",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (assignment["type"] == "image")
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        assignment["fileUrl"],
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => 
                                          Container(
                                            height: 180, 
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image_not_supported),
                                          ),
                                      ),
                                    ),
                                  if (assignment["type"] == "pdf")
                                    Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.red,
                                            size: 32,
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              "View PDF Document",
                                              style: TextStyle(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: isWide ? 18 : 15,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.open_in_new,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Uploaded by: ${assignment["uploadedBy"] ?? ""}",
                                        style: TextStyle(
                                          color: Colors.blueGrey[700],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
    );
  }
}

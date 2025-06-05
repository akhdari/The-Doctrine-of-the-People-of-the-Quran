import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, dynamic> sampleJson = {
  "schoolName": "المدرسة المتميزة",
  "fullName": "سارة علي",
  "dateOfBirth": "15 - 06 - 2005",
  "bloodGroup": "A+",
  "level": "إعدادي",
  "academicYear": "2022 - 2023",
  "phoneNumber": "71234567",
  "username": "student1004567",
};

class Student {
  final String schoolName;
  final String fullName;
  final String dateOfBirth;
  final String bloodGroup;
  final String level;
  final String academicYear;
  final String phoneNumber;
  final String username;

  Student({
    required this.schoolName,
    required this.fullName,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.level,
    required this.academicYear,
    required this.phoneNumber,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      schoolName: json['schoolName'] ?? '',
      fullName: json['fullName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      level: json['level'] ?? '',
      academicYear: json['academicYear'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

class StudentController extends GetxController {
  final student = Rxn<Student>();

  void loadStudentFromJson(Map<String, dynamic> json) {
    student.value = Student.fromJson(json);
  }
}

class StudentCard extends StatelessWidget {
  final String logoPath;

  const StudentCard({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final student = studentController.student.value!;

    return Center(
      child: SizedBox(
        width: 600,
        height: 400,
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: _buildFrontCard(student, logoPath),
          back: _buildBackCard(student),
        ),
      ),
    );
  }

  Widget _buildFrontCard(Student student, String logoPath) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with school name
            _buildHeader(student),
            const SizedBox(height: 16),

            // Student content
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side with avatar and logo
                    Column(
                      children: [
                        _buildStudentAvatar(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 80,
                          child: Image.asset(logoPath, fit: BoxFit.contain),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Right side with student info
                    Expanded(child: _buildStudentInfo(student)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Student student) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          student.schoolName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2.0),
      ),
      child: ClipOval(
        child: Image.asset('assets/avatar.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildStudentInfo(Student student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildInfoRow('الاسم الكامل', student.fullName),
        _buildInfoRow('تاريخ الميلاد', student.dateOfBirth),
        _buildInfoRow('زمرة الدم', student.bloodGroup),
        _buildInfoRow('المستوى', student.level),
        _buildInfoRow('السنة الدراسية', student.academicYear),
        _buildInfoRow('رقم الهاتف', student.phoneNumber),
        _buildInfoRow('اسم المستخدم', student.username),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard(Student student) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'بطاقة الطالب',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              student.schoolName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade600,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'الجهة الخلفية للبطاقة - معلومات إضافية\n'
                'يمكنك هنا إضافة بيانات مثل عنوان السكن، البريد الإلكتروني، أو توقيع الطالب.',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: 16),
            _buildQrCodePlaceholder(),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCodePlaceholder() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'QR Code',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}

class StudentSelectionPage extends StatelessWidget {
  const StudentSelectionPage({super.key});

  final List<Map<String, dynamic>> studentList = const [
    {
      "schoolName": "المدرسة المتميزة",
      "fullName": "سارة علي",
      "dateOfBirth": "15 - 06 - 2005",
      "bloodGroup": "A+",
      "level": "إعدادي",
      "academicYear": "2022 - 2023",
      "phoneNumber": "71234567",
      "username": "student1004567",
    },
    {
      "schoolName": "ثانوية المدينة",
      "fullName": "خالد يوسف",
      "dateOfBirth": "01 - 03 - 2004",
      "bloodGroup": "B-",
      "level": "ثانوي",
      "academicYear": "2021 - 2022",
      "phoneNumber": "70001234",
      "username": "student1001234",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final StudentController controller = Get.put(StudentController());

    return Scaffold(
      appBar: AppBar(title: const Text('بطاقة الطالب'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 400,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "اختر اسم الطالب",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    isExpanded: true,
                    items:
                        studentList.map((student) {
                          return DropdownMenuItem<String>(
                            value: student['username'],
                            child: Text(
                              student['fullName'],
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                    onChanged: (selectedUsername) {
                      final selected = studentList.firstWhere(
                        (student) => student['username'] == selectedUsername,
                      );
                      controller.loadStudentFromJson(selected);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    final student = controller.student.value;
                    if (student == null) {
                      return const Center(
                        child: Text(
                          "الرجاء اختيار طالب لعرض البطاقة",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    return StudentCard(logoPath: 'assets/logo.png');
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

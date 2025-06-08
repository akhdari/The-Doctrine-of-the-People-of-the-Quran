import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_field.dart'
    as custom_search; // import the search controller + widget

import 'package:flip_card/flip_card.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/screens/base_layout.dart';

// Student model same as before (you can keep it here or separate)
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

  Map<String, dynamic> toJson() {
    return {
      "schoolName": schoolName,
      "fullName": fullName,
      "dateOfBirth": dateOfBirth,
      "bloodGroup": bloodGroup,
      "level": level,
      "academicYear": academicYear,
      "phoneNumber": phoneNumber,
      "username": username,
    };
  }
}

// Your sample data
final List<Map<String, dynamic>> studentList = [
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
  {
    "schoolName": "مدرسة النور",
    "fullName": "أحمد محمد",
    "dateOfBirth": "22 - 09 - 2006",
    "bloodGroup": "O+",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71112233",
    "username": "student1002233",
  },
  {
    "schoolName": "ثانوية الفاروق",
    "fullName": "فاطمة حسن",
    "dateOfBirth": "05 - 12 - 2003",
    "bloodGroup": "AB+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70112233",
    "username": "student1003233",
  },
  {
    "schoolName": "مدرسة الأمل",
    "fullName": "عمر خالد",
    "dateOfBirth": "18 - 04 - 2007",
    "bloodGroup": "A-",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71223344",
    "username": "student1004334",
  },
  {
    "schoolName": "المدرسة النموذجية",
    "fullName": "نورا سعيد",
    "dateOfBirth": "30 - 07 - 2005",
    "bloodGroup": "B+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71334455",
    "username": "student1005445",
  },
  {
    "schoolName": "ثانوية العلوم",
    "fullName": "يوسف رامي",
    "dateOfBirth": "12 - 11 - 2004",
    "bloodGroup": "O-",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70334455",
    "username": "student1006445",
  },
  {
    "schoolName": "مدرسة المستقبل",
    "fullName": "ليلى وائل",
    "dateOfBirth": "25 - 02 - 2006",
    "bloodGroup": "A+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71556677",
    "username": "student1007667",
  },
  {
    "schoolName": "ثانوية الأدب",
    "fullName": "محمود إبراهيم",
    "dateOfBirth": "08 - 08 - 2003",
    "bloodGroup": "B-",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70556677",
    "username": "student1008667",
  },
  {
    "schoolName": "مدرسة السلام",
    "fullName": "هبة علي",
    "dateOfBirth": "14 - 01 - 2007",
    "bloodGroup": "AB-",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71667788",
    "username": "student1009778",
  },
  {
    "schoolName": "المدرسة الحديثة",
    "fullName": "طارق ناصر",
    "dateOfBirth": "03 - 05 - 2005",
    "bloodGroup": "O+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71778899",
    "username": "student1010889",
  },
  {
    "schoolName": "ثانوية الرياضيات",
    "fullName": "سلمى كمال",
    "dateOfBirth": "19 - 10 - 2004",
    "bloodGroup": "A-",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70778899",
    "username": "student1011889",
  },
  {
    "schoolName": "مدرسة النهضة",
    "fullName": "باسل سمير",
    "dateOfBirth": "27 - 03 - 2006",
    "bloodGroup": "B+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71889900",
    "username": "student1012990",
  },
  {
    "schoolName": "ثانوية اللغات",
    "fullName": "ريم أسامة",
    "dateOfBirth": "09 - 12 - 2003",
    "bloodGroup": "AB+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70889900",
    "username": "student1013990",
  },
  {
    "schoolName": "مدرسة المعرفة",
    "fullName": "زياد عماد",
    "dateOfBirth": "16 - 07 - 2007",
    "bloodGroup": "O-",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71990011",
    "username": "student1014001",
  },
  {
    "schoolName": "المدرسة العربية",
    "fullName": "نادين خليل",
    "dateOfBirth": "04 - 09 - 2005",
    "bloodGroup": "A+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71001122",
    "username": "student1015112",
  },
  {
    "schoolName": "ثانوية الفنون",
    "fullName": "جمال فاروق",
    "dateOfBirth": "21 - 02 - 2004",
    "bloodGroup": "B-",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70011223",
    "username": "student1016112",
  },
  {
    "schoolName": "مدرسة الأجيال",
    "fullName": "هاني ربيع",
    "dateOfBirth": "11 - 05 - 2006",
    "bloodGroup": "AB-",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71122334",
    "username": "student1017233",
  },
  {
    "schoolName": "ثانوية التكنولوجيا",
    "fullName": "لينا ماهر",
    "dateOfBirth": "28 - 11 - 2003",
    "bloodGroup": "O+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70122334",
    "username": "student1018233",
  },
  {
    "schoolName": "مدرسة الإبداع",
    "fullName": "وسام نبيل",
    "dateOfBirth": "07 - 04 - 2007",
    "bloodGroup": "A-",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71233445",
    "username": "student1019344",
  },
  {
    "schoolName": "المدرسة الدولية",
    "fullName": "دانا عدنان",
    "dateOfBirth": "23 - 08 - 2005",
    "bloodGroup": "B+",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71344556",
    "username": "student1020455",
  },
  {
    "schoolName": "ثانوية الطب",
    "fullName": "رامي وسام",
    "dateOfBirth": "15 - 01 - 2004",
    "bloodGroup": "AB+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70344556",
    "username": "student1021455",
  },
  {
    "schoolName": "مدرسة الهدى",
    "fullName": "إيمان رفعت",
    "dateOfBirth": "02 - 06 - 2006",
    "bloodGroup": "O-",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71455667",
    "username": "student1022566",
  },
  {
    "schoolName": "ثانوية الهندسة",
    "fullName": "باسم حازم",
    "dateOfBirth": "19 - 10 - 2003",
    "bloodGroup": "A+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70455667",
    "username": "student1023566",
  },
  {
    "schoolName": "مدرسة الفكر",
    "fullName": "جنى صبحي",
    "dateOfBirth": "08 - 03 - 2007",
    "bloodGroup": "B-",
    "level": "ابتدائي",
    "academicYear": "2023 - 2024",
    "phoneNumber": "71566778",
    "username": "student1024677",
  },
  {
    "schoolName": "المدرسة الخضراء",
    "fullName": "عاصم لؤي",
    "dateOfBirth": "26 - 07 - 2005",
    "bloodGroup": "AB-",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71677889",
    "username": "student1025788",
  },
  {
    "schoolName": "ثانوية القانون",
    "fullName": "سهام رامي",
    "dateOfBirth": "13 - 12 - 2004",
    "bloodGroup": "O+",
    "level": "ثانوي",
    "academicYear": "2021 - 2022",
    "phoneNumber": "70677889",
    "username": "student1026788",
  },
  {
    "schoolName": "مدرسة الرؤية",
    "fullName": "نادر حسان",
    "dateOfBirth": "05 - 05 - 2006",
    "bloodGroup": "A-",
    "level": "إعدادي",
    "academicYear": "2022 - 2023",
    "phoneNumber": "71788990",
    "username": "student1027899",
  },
];

// Controller to hold selected student data
class StudentController extends GetxController {
  final student = Rxn<Student>();

  void loadStudentFromJson(Map<String, dynamic> json) {
    student.value = Student.fromJson(json);
  }
}

// The student card (same as before, simplified here for clarity)
class StudentCard extends StatelessWidget {
  final String logoPath;

  const StudentCard({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentController>();
    final student = studentController.student.value!;

    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 600,
        height: 400,
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: _buildFrontCard(student, logoPath, theme),
          back: _buildBackCard(student, theme),
        ),
      ),
    );
  }

  Widget _buildFrontCard(Student student, String logoPath, ThemeData theme) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with school name
            _buildHeader(student, theme),
            const SizedBox(height: 16),

            // Student content
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: avatar and logo
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

                    // Right side: student info details
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

  Widget _buildHeader(Student student, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          student.schoolName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
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
              style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard(Student student, ThemeData theme) {
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
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              student.schoolName,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primaryContainer,
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

// Main page widget
class StudentSelectionPage extends StatelessWidget {
  const StudentSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Controller setup
    final StudentController studentController = Get.put(StudentController());
    final List<Student> students =
        studentList.map((json) => Student.fromJson(json)).toList();

    final custom_search.SearchController<Student> searchController = Get.put(
      custom_search.SearchController<Student>(
        items: students,
        filter: (student, query) =>
            student.fullName.toLowerCase().contains(query.toLowerCase()),
      ),
    );

    return BaseLayout(
      title: 'البحث عن طالب',
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 LEFT PANEL: Search + Results
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 60,
                    child: custom_search.SearchField<Student>(
                      controller: searchController,
                      hint: 'ابحث عن اسم الطالب',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Obx(() {
                      final filtered = searchController.filteredList;
                      final showResults = searchController.showResults.value;

                      if (!showResults) return const SizedBox();

                      if (filtered.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: theme.textTheme.titleMedium,
                            textDirection: TextDirection.rtl,
                          ),
                        );
                      }

                      return Scrollbar(
                        child: ListView.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final student = filtered[index];
                            return ListTile(
                              title: Text(
                                student.fullName,
                                textDirection: TextDirection.rtl,
                                style: theme.textTheme.titleMedium,
                              ),
                              onTap: () {
                                studentController
                                    .loadStudentFromJson(student.toJson());
                                searchController.reset();
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 40),

            // 🪪 RIGHT PANEL: StudentCard
            Expanded(
              flex: 2,
              child: Obx(() {
                final student = studentController.student.value;

                if (student == null) {
                  return Center(
                    child: Text(
                      "الرجاء اختيار طالب لعرض البطاقة",
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.displayLarge,
                    ),
                  );
                }

                return Align(
                  alignment: Alignment.topCenter,
                  child: StudentCard(logoPath: 'assets/logo.png'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

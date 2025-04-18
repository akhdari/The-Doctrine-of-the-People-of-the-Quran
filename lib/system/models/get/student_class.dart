class Student {
  final String id;
  final String firstNameAr;
  final String lastNameAr;
  final String sex;
  final String dateOfBirth;
  final String placeOfBirth;
  final String nationality;
  final String lectureNameAr;
  final String username;

  Student({
    required this.id,
    required this.firstNameAr,
    required this.lastNameAr,
    required this.sex,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.nationality,
    required this.lectureNameAr,
    required this.username,
  });

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student(
      id: map['student_id'].toString(),
      firstNameAr: map['first_name_ar'] ?? '',
      lastNameAr: map['last_name_ar'] ?? '',
      sex: map['sex'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      nationality: map['nationality'] ?? '',
      lectureNameAr: map['lecture_name_ar'] ?? '',
      username: map['username'] ?? '',
    );
  }

  // Add setters?
}

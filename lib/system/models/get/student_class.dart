import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';

class Student implements Model {
  final String id;
  final String firstNameAr;
  final String lastNameAr;
  final String sex;
  final String dateOfBirth;
  final String placeOfBirth;
  final String nationality;
  final String lectureNameAr;
  final String username;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstNameAr': firstNameAr,
      'lastNameAr': lastNameAr,
      'sex': sex,
      'dateOfBirth': dateOfBirth,
      'placeOfBirth': placeOfBirth,
      'nationality': nationality,
      'lectures': lectureNameAr,
      'username': username,
    };
  }

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
      id: map['id'].toString(),
      firstNameAr: map['firstNameAr'] ?? '',
      lastNameAr: map['lastNameAr'] ?? '',
      sex: map['sex'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      placeOfBirth: map['placeOfBirth'] ?? '',
      nationality: map['nationality'] ?? '',
      lectureNameAr: map['lectures'] ?? '',
      username: map['username'] ?? '',
    );
  }
}

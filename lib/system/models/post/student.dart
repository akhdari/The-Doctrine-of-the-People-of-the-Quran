import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/account_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/contact_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/formal_education_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/guardian.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/medical_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/personal_info.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/student.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/lecture.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/subscription_info.dart';
import 'abstract_class.dart';

class StudentInfoDialog extends AbstractClass implements Model {
  PersonalInfo personalInfo = PersonalInfo();
  AccountInfo accountInfo = AccountInfo();
  ContactInfo contactInfo = ContactInfo();
  MedicalInfo medicalInfo = MedicalInfo();
  Guardian guardian = Guardian();
  List<Lecture> lectures = [];
  Student student = Student();
  FormalEducationInfo formalEducationInfo = FormalEducationInfo();
  SubscriptionInfo subscriptionInfo = SubscriptionInfo();

  // Constructor for empty form initialization
  StudentInfoDialog();

  @override
  // Method to check if all required fields are filled
  bool get isComplete {
    return personalInfo.firstNameAr.isNotEmpty &&
        personalInfo.lastNameAr.isNotEmpty &&
        personalInfo.sex.isNotEmpty &&
        accountInfo.username.isNotEmpty &&
        accountInfo.passcode.isNotEmpty &&
        contactInfo.phoneNumber.isNotEmpty &&
        contactInfo.email.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'personalInfo': personalInfo.toJson(),
      'accountInfo': accountInfo.toJson(),
      'contactInfo': contactInfo.toJson(),
      'medicalInfo': medicalInfo.toJson(),
      'guardian': guardian.toJson(),
      'student': student.toJson(),
      'lectures': lectures.map((lecture) => lecture.toJson()).toList(),
      'formalEducationInfo': formalEducationInfo.toJson(),
      'subscriptionInfo': subscriptionInfo.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJson() {
    return toMap();
  }

  static StudentInfoDialog fromJson(Map<String, dynamic> json) {
    return StudentInfoDialog()
      ..personalInfo = PersonalInfo.fromJson(json['personalInfo'])
      ..accountInfo = AccountInfo.fromJson(json['accountInfo'])
      ..contactInfo = ContactInfo.fromJson(json['contactInfo'])
      ..medicalInfo = MedicalInfo.fromJson(json['medicalInfo'])
      ..guardian = Guardian.fromJson(json['guardian'])
      ..student = Student.fromJson(json['student'])
      ..lectures = (json['lectures'] as List)
          .map((lecture) => Lecture.fromJson(lecture))
          .toList()
      ..formalEducationInfo =
          FormalEducationInfo.fromJson(json['formalEducationInfo'])
      ..subscriptionInfo = SubscriptionInfo.fromJson(json['subscriptionInfo']);
  }
}

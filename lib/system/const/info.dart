class StudentInfoDialog {
  // Required fields (non-nullable)
  //personal ifo
  late String firstNameAR;
  late String lastNameAR;
  late String sex;
  //student account
  late String username;
  late String password;
  //student contact
  late String phoneNumber;
  late String emailAddress;

  // Optional fields (nullable)
  //sessions
  List<String>? sessions;
  //other personal info
  String? firstNameEN;
  String? lastNameEN;
  String? nationality;
  String? dateOfBirth;
  String? placeOfBirth;
  String? address;
  //medical info
  String? bloodType;
  String? hasDisease;
  String? diseaseCauses;
  String? allergies;

  //formal education
  String? schoolName;
  String? schoolType;
  String? grade;
  String? academicLevel;
  //subsription info
  String? enrollmentDate;
  String? exitDate;
  String? exitReason;
  bool? isExempt;
  double? exemptionPercent;
  String? exemptionReason;

  //gradian info
  String? firstName;
  String? lastName;
  String? dateOfBirth2;
  String? relationship;
  //guardian account
  String? username2;
  String? password2;
  String? imagePath2;
  //parents status
  String? motherStatus;
  String? fatherStatus;
  //other contact info
  String? imagePath;

  // Constructor for empty form initialization
  StudentInfoDialog();

  // Method to check if all required fields are filled
  bool get isComplete {
    return firstNameAR.isNotEmpty &&
        lastNameAR.isNotEmpty &&
        sex.isNotEmpty &&
        //username.isNotEmpty &&
        password.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        emailAddress.isNotEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'student': {
        'personalInfo': {
          'firstNameAR': firstNameAR,
          'lastNameAR': lastNameAR,
          'sex': sex,
          'firstNameEN': firstNameEN,
          'lastNameEN': lastNameEN,
          'nationality': nationality,
          'dateOfBirth': dateOfBirth,
          'placeOfBirth': placeOfBirth,
          'address': address,
        },
        'account': {
          'username': username,
          'password': password,
        },
        'contactInfo': {
          'phoneNumber': phoneNumber,
          'emailAddress': emailAddress,
        },
        'educationInfo': {
          'schoolName': schoolName,
          'schoolType': schoolType,
          'grade': grade,
          'academicLevel': academicLevel,
        },
        'subscriptionInfo': {
          'enrollmentDate': enrollmentDate,
          'exitDate': exitDate,
          'exitReason': exitReason,
          'isExempt': isExempt,
          'exemptionPercent': exemptionPercent,
          'exemptionReason': exemptionReason,
        },
        'medicalInfo': {
          'bloodType': bloodType,
          'hasDisease': hasDisease,
          'diseaseCauses': diseaseCauses,
          'allergies': allergies,
        },
      },
      'guardian': {
        'personalInfo': {
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth2,
          'relationship': relationship,
        },
        'account': {
          'username': username2,
          'password': password2,
        },
        'contactInfo': {
          'imagePath': imagePath2,
        },
        'parentsStatus': {
          'motherStatus': motherStatus,
          'fatherStatus': fatherStatus,
        },
      },
      'sessions': sessions, // list of sessions
    };
  }
}

//TODO (Automatic Code Generation)
class Student {
  String firstNameAr;
  String lastNameAr;
  String firstNameEn;
  String lastNameEn;
  String placeOfBirth;
  String dateOfBirth;
  String nationality;
  String lectureName; // TODO: may need to change the type
  String username;

  Student(
      this.firstNameAr,
      this.lastNameAr,
      this.firstNameEn,
      this.lastNameEn,
      this.placeOfBirth,
      this.dateOfBirth,
      this.nationality,
      this.lectureName,
      this.username);
  //TODO if null set to empty
  // // Convert JSON to Dart object
  factory Student.fromJson(Map<String, dynamic> json) {
    //json -> dart
    return Student(
      json['firstNameAr'],
      json['lastNameAr'],
      json['firstNameEn'],
      json['lastNameEn'],
      json['placeOfBirth'],
      json['dateOfBirth'],
      json['nationality'],
      json['lectureName'],
      json['username'],
    );
  }
  /*
  factory constructor classname.fromJson(map<String, dynamic> json) {
    return classConstructor(json['key']);
  }
  */
}

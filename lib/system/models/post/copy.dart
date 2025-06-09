import 'abstract_class.dart';

class Copy extends AbstractClass {
  String? schoolName;
  String? country;
  String? schoolAddress;
  String? name;
  String? supervisorName;
  String? phoneNumber;
  String? email;

  @override
  bool get isComplete {
    return schoolName != null &&
        country != null &&
        schoolAddress != null &&
        name != null &&
        supervisorName != null &&
        phoneNumber != null &&
        email != null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "schoolName": schoolName,
      "country": country,
      "schoolAddress": schoolAddress,
      "name": name,
      "nameOfSupervisor": supervisorName,
      "phoneNumber": phoneNumber,
      "email": email,
    };
  }
}

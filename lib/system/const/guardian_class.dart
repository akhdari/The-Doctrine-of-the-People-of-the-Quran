import 'abstract_class.dart';

class Guardian extends AbstractClass {
  //TODO extends Abstract class
  //info
  late String firstName;
  late String lastName;
  late String relationship;
  String? dateOfBirth;
  String? address;
  String? job;

  //account info
  late String email;
  late String phoneNumber;
  //contact info
  late String username;
  late String passcode;
  //account image
  String? imagePath;
  @override
  bool get isComplete {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        relationship.isNotEmpty &&
        username.isNotEmpty &&
        passcode.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "info": {
        "first_name": firstName,
        "last_name": lastName,
        "relationship": relationship,
        "date_of_birth": dateOfBirth,
        "home_address": address,
        "job": job,
      },
      "account_info": {
        "username": username,
        "passcode": passcode,
        "profile_image": imagePath,
      },
      "contact_info": {
        "email": email,
        "phone_number": phoneNumber,
      }
    };
  }
}

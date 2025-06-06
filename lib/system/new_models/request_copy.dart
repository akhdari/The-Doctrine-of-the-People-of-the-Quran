import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';
class RequestCopy implements Model {
 dynamic requestCopyId;
 dynamic username;
 dynamic firstName;
 dynamic lastName;
 dynamic email;
 dynamic phoneNumber;

  RequestCopy({
    this.requestCopyId,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  factory RequestCopy.fromJson(Map<String, dynamic> json) => RequestCopy(
    requestCopyId: json['request_copy_id'],
    username: json['username'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    phoneNumber: json['phone_number'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'request_copy_id': requestCopyId,
    'username': username,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone_number': phoneNumber,
  };
}


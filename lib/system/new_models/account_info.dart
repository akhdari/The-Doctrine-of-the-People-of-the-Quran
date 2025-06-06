import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';

class AccountInfo implements Model {
  dynamic accountId;
  dynamic username;
  dynamic passcode;
  dynamic accountType = "student"; // Default value

  AccountInfo({
    this.accountId,
    this.username,
    this.passcode,
    this.accountType,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        accountId: json['account_id'],
        username: json['username'],
        passcode: json['passcode'],
        accountType: json['account_type'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'account_id': accountId,
        'username': username,
        'passcode': passcode,
        'account_type': accountType,
      };
}

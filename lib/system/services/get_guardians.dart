import 'connect.dart';

const url = 'http://192.168.100.20/phpscript/guardians.php';

//TODO include guardian id

class GuardianResult {
  List<Guardian>? guardians;
  String? errorMessage;
  GuardianResult.onError({
    required this.errorMessage,
  }) : guardians = null;
  GuardianResult.onSuccess({
    required this.guardians,
  }) : errorMessage = null;
}

class Guardian {
  String username;
  Guardian({
    required this.username,
  });
  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      username: json['username'],
    );
  }
}

Future<GuardianResult> getGuardians() async {
  Connect connect = Connect();

  ApiResult<List<Map<String, dynamic>>> data;
  List<Map<String, dynamic>> guardians;
  List<Guardian> guardiansList;

  data = await connect.get(url);
  if (data.isSuccess) {
    guardians = data.data!;
    guardiansList = guardians.map((json) => Guardian.fromJson(json)).toList();

    return GuardianResult.onSuccess(guardians: guardiansList);
  } else {
    return GuardianResult.onError(errorMessage: data.errorMessage);
  }
}

import 'connect.dart';

const url = 'http://192.168.100.20/phpscript/sessions.php';

class SessionResult {
  final List<Session>? sessions;
  final String? errorMessage;
  SessionResult.onSuccess({required this.sessions}) : errorMessage = null;
  SessionResult.onError({required this.errorMessage}) : sessions = null;
}

class Session {
  final String sessionName;
  Session({required this.sessionName});
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      sessionName: json['lecture_name_ar'],
    );
  }
}

Future<SessionResult> getSessions() async {
  Connect connect = Connect();
  ApiResult<List<Map<String, dynamic>>> data;
  List<Map<String, dynamic>> sessions;
  List<Session> sessionsList = [];
  data = await connect.get(url);
  if (data.isSuccess) {
    sessions = data.data!;
    sessionsList = sessions.map((item) => Session.fromJson(item)).toList();
    return SessionResult.onSuccess(sessions: sessionsList);
  } else {
    return SessionResult.onError(errorMessage: data.errorMessage);
  }
}

class ApiEndpoints {
  static const String baseUrl = 'http://192.168.100.20/phpscript/';

  static const String partialUrl =
      '${baseUrl}acheivement_student_list.php?session_id=';
  static const String getLatestAchievement =
      '${baseUrl}get_latest_acheivement.php';
  static const String getLecture = '${baseUrl}lecture.php';
  static const String deleteLecture = '${baseUrl}delete_lecture.php';
  static const String typehead = '${baseUrl}typehead.php';
  static const String getGuardian = '${baseUrl}guardian.php';
  static const String deleteGuardian = '${baseUrl}delete_guardian.php';
  static const String getStudent = '${baseUrl}student.php';
  static const String deleteStudent = '${baseUrl}delete_student.php';
  static const String updateLecture = '${baseUrl}update_lecture.php';
  static const String postLecture = '${baseUrl}get_lecture.php';
  static const getTeachers = '${baseUrl}teachers.php';
}

class ApiEndpoints {
  static const String baseUrl =
      'http://192.168.100.50/quran/ahl_quran_backend/routes';

  // Achievement endpoints
  static String getStudentsByLecture(int sessionId) =>
      '$baseUrl/achievement_route.php?action=get_students_by_lecture&session_id=$sessionId';

  static const String getLatestAchievements =
      '$baseUrl/achievement_route.php?action=get_latest_achievements';

  // Lecture endpoints
  static const String getLectures =
      '$baseUrl/lecture_route.php?action=get_lecture_info';

  static String getLectureById(int id) =>
      '$baseUrl/lecture_route.php?action=get_lecture_by_id&id=$id';

  static const String deleteLecture =
      '$baseUrl/lecture_route.php?action=delete_lecture';

  static const String getLectureIdName =
      '$baseUrl/lecture_route.php?action=get_lecture_id_name';

  static const String createLecture =
      '$baseUrl/lecture_route.php?action=create_lecture';

  static const String updateLecture =
      '$baseUrl/lecture_route.php?action=update_lecture';

  // Guardian endpoints
  static const String getGuardians =
      '$baseUrl/guardian_route.php?action=get_guardian_info';

  static const String deleteGuardian =
      '$baseUrl/guardian_route.php?action=delete_guardian';

  static const String getGuardianAccounts =
      '$baseUrl/guardian_route.php?action=get_guardian_accounts';

  static const String createGuardian =
      '$baseUrl/guardian_route.php?action=create_guardian';

  // Student endpoints
  static const String getStudents =
      '$baseUrl/student_route.php?action=get_student_info';

  static const String createStudent =
      '$baseUrl/student_route.php?action=create_student';

  static const String deleteStudent =
      '$baseUrl/student_route.php?action=delete_student';

  // Teacher endpoints
  static const String getTeachers =
      '$baseUrl/teacher_route.php?action=get_teachers';
}

class ApiEndpoints {
  static const String baseUrl =
      'http://192.168.100.50/quran/ahl_quran_backend/api/v1';

  // AccountInfo endpoints
  static const String getAccountInfos = '$baseUrl/accountinfos';
  static String getAccountInfoById(int id) => '$baseUrl/accountinfos/$id';

  // Appreciation endpoints
  static const String getAppreciations = '$baseUrl/appreciations';
  static String getAppreciationById(int id) => '$baseUrl/appreciations/$id';

  // ContactInfo endpoints
  static const String getContactInfos = '$baseUrl/contactinfos';
  static String getContactInfoById(int id) => '$baseUrl/contactinfos/$id';

  // Exam endpoints
  static const String getExams = '$baseUrl/exams';
  static String getExamById(int id) => '$baseUrl/exams/$id';

  // ExamLevel endpoints
  static const String getExamLevels = '$baseUrl/examlevels';
  static String getExamLevelById(int id) => '$baseUrl/examlevels/$id';

  // ExamStudent endpoints
  static const String getExamStudents = '$baseUrl/examstudents';
  static String getExamStudentById(int examId, int studentId) =>
      '$baseUrl/examstudents/exams/$examId/students/$studentId';

  // ExamTeacher endpoints
  static const String getExamTeachers = '$baseUrl/examteachers';
  static String getExamTeacherById(int examId, int teacherId) =>
      '$baseUrl/examteachers/exams/$examId/teachers/$teacherId';

  // FormalEducationInfo endpoints
  static const String getFormalEducationInfos = '$baseUrl/formaleducationinfos';
  static String getFormalEducationInfoById(int id) =>
      '$baseUrl/formaleducationinfos/$id';

  // GoldenRecord endpoints
  static const String getGoldenRecords = '$baseUrl/goldenrecords';
  static String getGoldenRecordById(int id) => '$baseUrl/goldenrecords/$id';

  // Guardian endpoints
  static const String getGuardians = '$baseUrl/guardians';
  static String getGuardianById(int id) => '$baseUrl/guardians/$id';

  // LectureContent endpoints
  static const String getLectureContents = '$baseUrl/lecturecontents';
  static String getLectureContentById(int id) => '$baseUrl/lecturecontents/$id';

  // Lecture endpoints
  static const String getLectures = '$baseUrl/lectures';
  static String getLectureById(int id) => '$baseUrl/lectures/$id';

  // LectureStudent endpoints
  static const String getLectureStudents = '$baseUrl/lecturestudents';
  static String getLectureStudentById(int lectureId, int studentId) =>
      '$baseUrl/lecturestudents/lectures/$lectureId/students/$studentId';

  // LectureTeacher endpoints
  static const String getLectureTeachers = '$baseUrl/lectureteachers';
  static String getLectureTeacherById(int lectureId, int teacherId) =>
      '$baseUrl/lectureteachers/lectures/$lectureId/teachers/$teacherId';

  // MedicalInfo endpoints
  static const String getMedicalInfos = '$baseUrl/medicalinfos';
  static String getMedicalInfoById(int id) => '$baseUrl/medicalinfos/$id';

  // PersonalInfo endpoints
  static const String getPersonalInfos = '$baseUrl/personalinfos';
  static String getPersonalInfoById(int id) => '$baseUrl/personalinfos/$id';

  // RequestCopy endpoints
  static const String getRequestCopys = '$baseUrl/requestcopys';
  static String getRequestCopyById(int id) => '$baseUrl/requestcopys/$id';

  // Student endpoints
  static const String getStudents = '$baseUrl/students';
  static String getStudentById(int id) => '$baseUrl/students/$id';

  // SubscriptionInfo endpoints
  static const String getSubscriptionInfos = '$baseUrl/subscriptioninfos';
  static String getSubscriptionInfoById(int id) =>
      '$baseUrl/subscriptioninfos/$id';

  // Supervisor endpoints
  static const String getSupervisors = '$baseUrl/supervisors';
  static String getSupervisorById(int id) => '$baseUrl/supervisors/$id';

  // Teacher endpoints
  static const String getTeachers = '$baseUrl/teachers';
  static String getTeacherById(int id) => '$baseUrl/teachers/$id';

  // TeamAccomplishment endpoints
  static const String getTeamAccomplishments = '$baseUrl/teamaccomplishments';
  static String getTeamAccomplishmentById(int id) =>
      '$baseUrl/teamaccomplishments/$id';

  // TeamAccomplishmentStudent endpoints
  static const String getTeamAccomplishmentStudents =
      '$baseUrl/teamaccomplishmentstudents';
  static String getTeamAccomplishmentStudentById(int teamId, int studentId) =>
      '$baseUrl/teamaccomplishmentstudents/teamaccomplishments/$teamId/students/$studentId';

  // WeeklySchedule endpoints
  static const String getWeeklySchedules = '$baseUrl/weeklyschedules';
  static String getWeeklyScheduleById(int id) => '$baseUrl/weeklyschedules/$id';
}

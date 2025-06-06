import '/system/models/post/surah_ayah.dart';
import 'abstract_class.dart';

class Acheivement extends AbstractClass {
  int? lectureId;
  int? studentId;
  String? date;
  List<SurahAyah> hifd = [];
  List<SurahAyah> quickRev = [];
  List<SurahAyah> majorRev = [];
  String? teacherNote;
  String? attendanceStatus;

  Acheivement();

  @override
  bool get isComplete {
    return hifd.isNotEmpty || quickRev.isNotEmpty || majorRev.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "lectureId": lectureId,
      "studentId": studentId,
      "date": date,
      "hifd": hifd.map((item) => item.toMap()).toList(),
      "quickRev": quickRev.map((item) => item.toMap()).toList(),
      "majorRev": majorRev.map((item) => item.toMap()).toList(),
      "attendenceStatus": attendanceStatus,
      "teacherNote": teacherNote ?? '',
    };
  }

  factory Acheivement.fromMap(Map<String, dynamic> map) {
    return Acheivement()
      ..lectureId = map['lectureId'] as int?
      ..studentId = map['studentId'] as int?
      ..date = map['date'] as String?
      ..hifd = (map['hifd'] as List<dynamic>? ?? [])
          .map((item) => SurahAyah.fromMap(item as Map<String, dynamic>))
          .toList()
      ..quickRev = (map['quickRev'] as List<dynamic>? ?? [])
          .map((item) => SurahAyah.fromMap(item as Map<String, dynamic>))
          .toList()
      ..majorRev = (map['majorRev'] as List<dynamic>? ?? [])
          .map((item) => SurahAyah.fromMap(item as Map<String, dynamic>))
          .toList()
      ..attendanceStatus = map['attendenceStatus'] as String?
      ..teacherNote = map['teacherNote'] as String?;
  }
}

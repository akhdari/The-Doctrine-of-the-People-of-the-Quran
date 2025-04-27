import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/surah_ayah.dart';

import 'abstract_class.dart';

class Acheivement extends AbstractClass {
  List<SurahAyah> sessionInfo = [SurahAyah()]; // Initialize with one item

  List<SurahAyah> hifd = [];
  List<SurahAyah> quickRev = [];
  List<SurahAyah> majorRev = [];
  String? teacherNote;
  String attendenceStatus = '';

  @override
  bool get isComplete {
    return hifd.isNotEmpty || quickRev.isNotEmpty || majorRev.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "sessionInfo": sessionInfo.map((item) => item.toMap()).toList(),
      "hifd": hifd.map((item) => item.toMap()).toList(),
      "quickRev": quickRev.map((item) => item.toMap()).toList(),
      "majorRev": majorRev.map((item) => item.toMap()).toList(),
      "attendenceStatus": attendenceStatus,
      "teacherNote": teacherNote ?? '',
    };
  }
}

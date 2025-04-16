import 'package:the_doctarine_of_the_ppl_of_the_quran/system/const/surah_ayah.dart';

import 'abstract_class.dart';

class Acheivement extends AbstractClass {
//hifd info
  List<SurahAyah> hifd = [];
//quick revision
  List<SurahAyah> quickRev = [];

//major revision
  List<SurahAyah> majorRev = [];

  @override
  bool get isComplete {
    return hifd.isNotEmpty || quickRev.isNotEmpty || majorRev.isNotEmpty;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "hifd": hifd.map((item) => item.toMap()).toList(),
      "quickRev": quickRev.map((item) => item.toMap()).toList(),
      "majorRev": majorRev.map((item) => item.toMap()).toList(),
    };
  }
}

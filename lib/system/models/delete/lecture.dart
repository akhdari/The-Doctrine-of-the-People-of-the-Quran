import '../post/abstract_class.dart';

class LectureDeleteRequest extends AbstractClass {
  final int id;

  LectureDeleteRequest(this.id);

  @override
  Map<String, dynamic> toMap() => {'id': id};
  @override
  bool get isComplete => true;
}

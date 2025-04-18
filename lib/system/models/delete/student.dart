import '../post/abstract_class.dart';

class StudentDeleteRequest extends AbstractClass {
  final int id;

  StudentDeleteRequest(this.id);

  @override
  Map<String, dynamic> toMap() => {'id': id};
  @override
  bool get isComplete => true;
}

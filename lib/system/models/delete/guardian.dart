import '../post/abstract_class.dart';

class GuardianDeleteRequest extends AbstractClass {
  final int id;

  GuardianDeleteRequest(this.id);

  @override
  Map<String, dynamic> toMap() => {'id': id};
  @override
  bool get isComplete => true;
}

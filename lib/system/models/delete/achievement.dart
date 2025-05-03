import '../post/abstract_class.dart';

class AchievementDeleteRequest implements AbstractClass {
  final int id;

  AchievementDeleteRequest(this.id);

  @override
  bool get isComplete => true;

  @override
  Map<String, dynamic> toMap() => {'id': id};
}

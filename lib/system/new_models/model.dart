abstract class Model {
  Map<String, dynamic> toJson();
  factory Model.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError(
        'fromJson method must be implemented in subclasses');
  }
  List<int> getPrimaryKey();
}

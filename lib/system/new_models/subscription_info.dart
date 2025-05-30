import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';class SubscriptionInfo implements Model {
  dynamic subscriptionId;
  dynamic studentId;
  dynamic enrollmentDate;
  dynamic exitDate;
  dynamic exitReason;

  SubscriptionInfo({
    this.subscriptionId,
    this.studentId,
    this.enrollmentDate,
    this.exitDate,
    this.exitReason,
  });

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) => SubscriptionInfo(
    subscriptionId: json['subscription_id'],
    studentId: json['student_id'],
    enrollmentDate: json['enrollment_date'],
    exitDate: json['exit_date'],
    exitReason: json['exit_reason'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'subscription_id': subscriptionId,
    'student_id': studentId,
    'enrollment_date': enrollmentDate,
    'exit_date': exitDate,
    'exit_reason': exitReason,
  };
}


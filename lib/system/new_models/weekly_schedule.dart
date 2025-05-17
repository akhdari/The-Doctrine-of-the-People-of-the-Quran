import 'package:the_doctarine_of_the_ppl_of_the_quran/system/new_models/model.dart';class WeeklySchedule implements Model {
  dynamic weeklyScheduleId;
  dynamic dayOfWeek;
  dynamic lectureId;

  WeeklySchedule({
    this.weeklyScheduleId,
    this.dayOfWeek,
    this.lectureId,
  });

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) => WeeklySchedule(
    weeklyScheduleId: json['weekly_schedule_id'],
    dayOfWeek: json['day_of_week'],
    lectureId: json['lecture_id'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'weekly_schedule_id': weeklyScheduleId,
    'day_of_week': dayOfWeek,
    'lecture_id': lectureId,
  };
}


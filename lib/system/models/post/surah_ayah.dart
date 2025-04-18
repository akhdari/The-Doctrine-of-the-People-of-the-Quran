import 'package:flutter/material.dart';

class SurahAyah {
  UniqueKey key;
  String? fromSurahName;
  String? toSurahName;
  int? fromAyahNumber;
  int? toAyahNumber;
  String? observation;

  SurahAyah(
      {this.fromSurahName,
      this.toSurahName,
      this.fromAyahNumber,
      this.toAyahNumber,
      this.observation})
      : key = UniqueKey();
  Map<String, dynamic> toMap() => {
        'fromSurahName': fromSurahName,
        'toSurahName': toSurahName,
        'fromAyahNumber': fromAyahNumber,
        'toAyahNumber': toAyahNumber,
        'observation': observation
      };
/*
  SurahAyah.convert(this.fromSurahName, this.toSurahName, this.fromAyahNumber,
      this.toAyahNumber, this.observation,);

  factory SurahAyah.fromMap(Map<String, dynamic> map) => SurahAyah.convert(
      map['fromSurahName'],
      map['toSurahName'],
      map['fromAyahNumber'],
      map['toAyahNumber'],
      map['observation']);*/
}

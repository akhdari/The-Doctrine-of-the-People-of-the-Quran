import 'package:flutter/material.dart';
import '../reports/report_screen.dart';
import '../reports/report1.dart' as report1;
import '../data/report1_data.dart' as data1;
import '../reports/pdf_generator.dart' as pdf_generator;
import '../system/models/shared.dart' as shared;
import '../system/models/report1_model.dart' as model1;
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/utils/font_loader.dart';

class Report1Screen extends StatelessWidget {
  final fonts = Get.find<FontController>();
  Report1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final reportData = data1.createSampleReport();

    return ReportScreen(
      title: 'تقرير ١',
      generateReportPdf: (data) => pdf_generator.generateReportPdf(
        reportDataModel: reportData,
        buildContent: ({
          required reportDataModel,
          required baseFont,
          required boldFont,
          required fallbackFont,
        }) {
          return report1.buildReport1Content(
            reportDataModel: reportDataModel
                as shared.FullReport<model1.OverallSummary1>, // 👈 cast here
            baseFont: baseFont,
            boldFont: boldFont,
            fallbackFont: fallbackFont,
          );
        },
        inputArabicFont: fonts.arabicFont,
        inputArabicFontBold: fonts.arabicFontBold,
        inputFallbackFont: fonts.fallbackFont,
      ),
    );
  }
}

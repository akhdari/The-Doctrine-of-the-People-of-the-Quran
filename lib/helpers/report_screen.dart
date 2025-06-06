import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data'; // Uint8List
import 'dart:async'; // FutureOr
import 'package:pdf/pdf.dart'; // PdfPageFormat
import '../system/utils/snackbar_helper.dart'; // showErrorSnackbar, showSuccessSnackbar

class ReportScreen extends StatelessWidget {
  const ReportScreen({
    super.key,
    required this.generateReportPdf,
    required this.title,
  });

  final String title;
  final FutureOr<Uint8List> Function(PdfPageFormat) generateReportPdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PdfPreview(
        build: (format) => generateReportPdf(format),
        canChangePageFormat: false,
        canChangeOrientation: false,
        allowPrinting: true,
        allowSharing: true,
        pdfFileName: "$title.pdf",
        enableScrollToPage: true, // ✅ Enables page scrolling with side bar
        dynamicLayout: true, // ✅ Makes layout responsive
        maxPageWidth: 700,
        scrollViewDecoration: BoxDecoration(color: Colors.grey[100]),
        pdfPreviewPageDecoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        loadingWidget: const Center(child: CircularProgressIndicator()),
        onError: (context, error) {
          showErrorSnackbar(context, "Failed to load PDF: $error");
          return Center(child: Text("Failed to load PDF."));
        },
        /*onPrinted:
            (context) =>
                showSuccessSnackbar(context, "Document printed successfully"),*/
        onShared: (context) =>
            showSuccessSnackbar(context, "Document shared successfully"),
      ),
    );
  }
}

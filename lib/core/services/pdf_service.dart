import 'dart:io';
import 'package:ai_setu/core/models/pdf_models.dart';
import 'package:ai_setu/modules/settings/company_profile/controllers/company_profile_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';

class PdfService {
  static final PdfService instance = PdfService._();
  PdfService._();

  static Future<void> generateAndPrint(DetailPdfData data) async {
    final doc = await _generateDocument(data);
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: data.filename ?? '${data.title}.pdf',
    );
  }

  static Future<void> generateAndShare(DetailPdfData data) async {
    final doc = await _generateDocument(data);
    final bytes = await doc.save();
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/${data.filename ?? "${data.title}.pdf"}',
    );
    await file.writeAsBytes(bytes);

    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: data.title),
    );
  }

  static Future<void> generateAndDownload(DetailPdfData data) async {
    final doc = await _generateDocument(data);
    final bytes = await doc.save();

    if (Platform.isAndroid || Platform.isIOS) {
      await Printing.sharePdf(
        bytes: bytes,
        filename: data.filename ?? '${data.title}.pdf',
      );
    } else {
      // Desktop logic
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final file = File(
          '${directory.path}/${data.filename ?? "${data.title}.pdf"}',
        );
        await file.writeAsBytes(bytes);
        Get.snackbar("Success", "PDF saved to Downloads");
      }
    }
  }

  static Future<pw.Document> _generateDocument(DetailPdfData data) async {
    final doc = pw.Document();
    final company = CompanyProfileController.instance.company.value;

    // Load fonts if needed, here we use standard ones
    final font = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interBold();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        header: (context) => _buildHeader(data, company),
        footer: (context) => _buildFooter(context, data),
        build: (context) => [
          pw.SizedBox(height: 20),
          ...data.sections.map((section) => _buildSection(section, fontBold)),
        ],
      ),
    );

    return doc;
  }

  static pw.Widget _buildHeader(DetailPdfData data, dynamic company) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  data.title.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue900,
                  ),
                ),
                if (data.subtitle != null) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(
                    data.subtitle!,
                    style: const pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
                if (data.status != null) ...[
                  pw.SizedBox(height: 8),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      data.status!.toUpperCase(),
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blue800,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (company != null)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    company.name,
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Container(
                    width: 250,
                    child: pw.Text(
                      '${company.address.address}, ${company.address.city.name}, ${company.address.state.name} - ${company.address.pinCode}',
                      textAlign: pw.TextAlign.right,
                      style: const pw.TextStyle(
                        fontSize: 9,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ),
                  pw.Text(
                    'Email: ${company.email} | Phone: ${company.phoneNo}',
                    style: const pw.TextStyle(
                      fontSize: 9,
                      color: PdfColors.grey800,
                    ),
                  ),
                  if (company.webSite != null && company.webSite!.isNotEmpty)
                    pw.Text(
                      'Web: ${company.webSite}',
                      style: const pw.TextStyle(
                        fontSize: 9,
                        color: PdfColors.grey800,
                      ),
                    ),
                  pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      if (company.gstIdentificationNumber != null &&
                          company.gstIdentificationNumber!.isNotEmpty)
                        pw.Text(
                          'GSTIN: ${company.gstIdentificationNumber}  ',
                          style: pw.TextStyle(
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      if (company.panNo != null && company.panNo!.isNotEmpty)
                        pw.Text(
                          'PAN: ${company.panNo}',
                          style: pw.TextStyle(
                            fontSize: 9,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
        pw.SizedBox(height: 10),
        pw.Divider(color: PdfColors.grey400),
      ],
    );
  }

  static pw.Widget _buildSection(PdfSectionData section, pw.Font fontBold) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 15),
        pw.Text(
          section.title,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue700,
          ),
        ),
        pw.SizedBox(height: 8),
        if (section.items != null)
          pw.Wrap(
            spacing: 20,
            runSpacing: 10,
            children: section.items!
                .map(
                  (item) => pw.Container(
                    width: 150,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          item.label.toUpperCase(),
                          style: const pw.TextStyle(
                            fontSize: 8,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          item.value,
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        if (section.table != null) ...[
          pw.SizedBox(height: 10),
          pw.TableHelper.fromTextArray(
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue700),
            cellAlignment: pw.Alignment.centerLeft,
            headerAlignment: pw.Alignment.centerLeft,
            cellStyle: const pw.TextStyle(fontSize: 9),
            headers: section.table!.headers,
            data: section.table!.rows,
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildFooter(pw.Context context, DetailPdfData data) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey400),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            if (data.footerText != null)
              pw.Text(
                data.footerText!,
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey600,
                ),
              )
            else
              pw.SizedBox(),
            pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }
}

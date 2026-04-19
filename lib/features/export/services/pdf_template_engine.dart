import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../shared/models/database/meeting_note.dart';

enum PdfTemplate { formal, minimal }

class PdfTemplateEngine {
  Future<void> exportNote(MeetingNote note, {PdfTemplate template = PdfTemplate.formal}) async {
    final pdf = pw.Document();

    if (template == PdfTemplate.formal) {
      _buildFormalTemplate(pdf, note);
    } else {
      _buildMinimalTemplate(pdf, note);
    }

    await Printing.sharePdf(bytes: await pdf.save(), filename: '${note.title}.pdf');
  }

  void _buildFormalTemplate(pw.Document pdf, MeetingNote note) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 20),
          child: pw.Text('NOTULENSI - MEETING REPORT', style: const pw.TextStyle(color: PdfColors.grey400, fontSize: 10)),
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 20),
          child: pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: const pw.TextStyle(fontSize: 10)),
        ),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(note.title.toUpperCase(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)),
                pw.Text(DateFormat('yyyy-MM-dd').format(note.createdAt)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Paragraph(
            text: note.transcript,
            style: const pw.TextStyle(lineSpacing: 1.5, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _buildMinimalTemplate(pw.Document pdf, MeetingNote note) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(note.title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18)),
          pw.Divider(),
          pw.SizedBox(height: 10),
          pw.Text(note.transcript),
        ],
      ),
    );
  }
}

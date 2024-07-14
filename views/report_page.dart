import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key}); // Uso del super.parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Reporte PDF'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Llamar al método para generar el PDF
            generatePdf(context);
          },
          child: const Text('Generar Reporte PDF'),
        ),
      ),
    );
  }

  Future<void> generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('¡Hola! Este es un reporte en PDF'),
          ); // Center
        },
      ),
    );

    // Mostrar vista previa del PDF generado
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
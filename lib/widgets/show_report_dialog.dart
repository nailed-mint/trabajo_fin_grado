import 'package:flutter/material.dart';
import 'package:tfg_redesign/models/report.dart';

class ShowReportInfo extends StatelessWidget {
  final Report report;

  const ShowReportInfo({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return reportForm(context);
  }

  AlertDialog reportForm(BuildContext context) {
    return AlertDialog(
      title: const Text("Informe"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(report.id.toString()),
            Text(report.userId.toString())
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Volver"),
        ),
      ],
    );
  }
}

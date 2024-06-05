import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trabajo_fin_grado/models/report.dart';

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
            Text("id: ${report.id.toString()}"),
            Text(
              "created on: ${DateFormat('dd-MM-yyy').format(report.createdOn!)}",
            ),
            Text("userName: ${report.userName.toString()}")
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

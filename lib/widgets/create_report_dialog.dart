import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/report.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';
import 'package:trabajo_fin_grado/providers/report_provider.dart';
import 'package:trabajo_fin_grado/models/match.dart';

class CreateReportDialog extends StatefulWidget {
  @override
  State<CreateReportDialog> createState() => _CreateReportDialogState();
}

class _CreateReportDialogState extends State<CreateReportDialog> {
  MatchProvider matchProvider = MatchProvider();
  ReportProvider reportProvider = ReportProvider();

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear nuevo informe'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Nombre',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            print("Generación de reporte");
            String name = _controller.text;
            // TODO: crear informe y actualizar las partidas relacionadas
            Future<List<Match>> matchList = matchProvider.readUnreported();
            matchList.then((matches) {
              if (matches.length > 0) {
                Report report = Report(
                  createdOn: DateTime.now(),
                  userName: name,
                );
                Future<int> id = reportProvider.create(report: report);
                id.then((_id) {
                  for (var match in matches) {
                    Map<String, dynamic> matchMap = match.toMap();
                    matchMap['reportId'] = _id;
                    Match newMatch = Match.fromSqfliteDatabase(matchMap);
                    matchProvider.update(match: newMatch);
                    print("- ${newMatch.toMap()}");
                  }
                  print("informe $_id creado para $name");
                });
              } else {
                print(
                  "informe para $name no creado (No hay partidas sin informar)",
                );
              }
            });

            Navigator.of(context).pop();
          },
          child: const Text('Crear'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

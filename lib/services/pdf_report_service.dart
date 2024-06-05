import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_document/my_files/init.dart';

import 'package:trabajo_fin_grado/models/game.dart';
import 'package:trabajo_fin_grado/models/match.dart';
import 'package:trabajo_fin_grado/models/report.dart';
import 'package:trabajo_fin_grado/providers/game_provider.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';

class PdfReportService {
  Future<Map<String, dynamic>> buildReport({required Report report}) async {
    final MatchProvider matchProvider = MatchProvider();
    final GameProvider gameProvider = GameProvider();

    Map<String, dynamic> res = {};

    res['name'] = report.userName;
    res['date'] = DateFormat('dd-MM-yyy').format(report.createdOn!);
    res['summary'] = [];
    res['matches'] = [];

    // Retrieve all matches related to this report
    List<Match> query = await matchProvider.readByReportId(report.id!);

    List<List<Match>> groupedMatches =
        groupBy(query, (Match match) => match.gameId).values.toList();

    for (List<Match> item in groupedMatches) {
      if (item.isNotEmpty) {
        Game game = await gameProvider.readById(item.first.gameId!);

        res['matches'].add({"game": game.name, "data": item});
      }
    }

    // Create a summary per game
    for (Map<String, dynamic> game in res['matches']) {
      List<int> hits = [];
      List<int> errors = [];
      List<int> durations = [];

      double? avgHits;
      double? avgErrors;
      double? avgDurations;

      for (Match match in game['data']) {
        hits.add(match.hits!);
        errors.add(match.errors!);
        durations.add(match.duration!);
      }

      if (hits.isNotEmpty) {
        avgHits = hits.reduce((a, b) => a + b) / hits.length;
      }

      if (errors.isNotEmpty) {
        avgErrors = errors.reduce((a, b) => a + b) / errors.length;
      }

      if (durations.isNotEmpty) {
        avgDurations = durations.reduce((a, b) => a + b) / durations.length;
      }

      res['summary'].add({
        "game": game['game'],
        "avgHits": avgHits,
        "avgErrors": avgErrors,
        "avgDurations": avgDurations,
      });
    }

    print(" buildReport - res: $res"); // debug
    return res;
  }

  Future<Uint8List> createDocument({required Map<String, dynamic> data}) {
    final pdf = pw.Document();

    final String name = data['name'];
    final String date = data['date'];
    final List<dynamic> summary = data['summary'];
    final List<dynamic> matches = data['matches'];

    // Summary page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<pw.SpanningWidget> summaryData = [];
          for (var item in summary) {
            print("CONCHETUMARE ${item['avgDurations'].runtimeType}");
            int seconds = (item['avgDurations'] ?? 0).round();
            Duration duration = Duration(seconds: seconds);

            String twoDigits(int n) {
              if (n >= 10) return "$n";
              return "0$n";
            }

            String twoDigitMinutes =
                twoDigits(duration.inMinutes.remainder(60));
            String twoDigitSeconds =
                twoDigits(duration.inSeconds.remainder(60));
            String formattedTime =
                "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

            summaryData.add(
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Juego"),
                      pw.Text("Media de aciertos"),
                      pw.Text("Media de errores"),
                      pw.Text("Tiempo medio para completar"),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(item['game']),
                      pw.Text(item['avgHits'].toString()),
                      pw.Text(item['avgErrors'].toString()),
                      pw.Text(formattedTime),
                    ],
                  ),
                ],
              ),
            );
            summaryData.add(pw.SizedBox(height: 15));
          }

          return pw.Column(
            children: [
                  // Row with general data of report
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Nombre"),
                          pw.Text("Fecha"),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(name),
                          pw.Text(date),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                ] +
                summaryData, // Rows with summary data
          );
        },
      ),
    );

    // Matches pages
    for (var game in matches) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                    // Row with general data of report
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Nombre"),
                            pw.Text("Fecha"),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(name),
                            pw.Text(date),
                          ],
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 30),

                    // Name of the game
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          game['game'].toUpperCase(),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                  ] +
                  formatMatchData(matches: game['data']),
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  Future<void> savePdfFile({
    required String fileName,
    required Uint8List data,
  }) async {
    // Define the path to be stored
    final output = await getTemporaryDirectory();
    String filePath = "${output.path}/$fileName.pdf";

    // Save the file
    final file = File(filePath);
    await file.writeAsBytes(data);

    // Open the file automatically
    await OpenDocument.openDocument(filePath: filePath);
  }

  List<pw.SpanningWidget> formatMatchData({required List<Match> matches}) {
    List<pw.SpanningWidget> response = [];
    for (var item in matches) {
      int seconds = item.duration ?? 0;
      Duration duration = Duration(seconds: seconds);

      String twoDigits(int n) {
        if (n >= 10) return "$n";
        return "0$n";
      }

      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      String formattedTime =
          "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";

      response.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Fecha de partida"),
                pw.Text("Duración"),
                pw.Text("Aciertos"),
                pw.Text("Errores"),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(DateFormat('dd-MM-yyy').format(item.createdOn!)),
                pw.Text(formattedTime),
                pw.Text(item.hits.toString()),
                pw.Text(item.errors.toString()),
              ],
            ),
          ],
        ),
      );
      response.add(pw.SizedBox(height: 15));
    }
    return response;
  }
}

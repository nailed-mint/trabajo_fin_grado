import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/game.dart';
import 'package:trabajo_fin_grado/models/match.dart';
import 'package:trabajo_fin_grado/models/report.dart';
import 'package:trabajo_fin_grado/providers/game_provider.dart';
import 'package:trabajo_fin_grado/providers/match_provider.dart';
import 'package:trabajo_fin_grado/providers/report_provider.dart';
import 'package:trabajo_fin_grado/services/pdf_report_service.dart';
import 'package:trabajo_fin_grado/widgets/create_report_dialog.dart';
import 'package:trabajo_fin_grado/widgets/show_game_info.dart';
import 'package:trabajo_fin_grado/widgets/show_match_dialog.dart';
import 'package:trabajo_fin_grado/widgets/show_report_dialog.dart';
import 'package:trabajo_fin_grado/widgets/sidenav_drawer.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  Future<List<Game>>? futureGames;
  Future<List<Match>>? futureMatches;
  Future<List<Report>>? futureReports;
  final gameProvider = GameProvider();
  final matchProvider = MatchProvider();
  final reportProvider = ReportProvider();

  final pdfReportService = PdfReportService();

  @override
  void initState() {
    super.initState();

    readAll();
  }

  void readAll() {
    setState(() {
      futureGames = gameProvider.readAll();
      futureMatches = matchProvider.readAll();
      futureReports = reportProvider.readAll();
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          drawer: const SidenavDrawer(),
          appBar: AppBar(
            title: const Text('Visualización de Datos'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.history),
                ),
                Tab(
                  icon: Icon(Icons.report),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: matchList(),
              ),
              Center(
                child: reportList(),
              ),
            ],
          ),
          floatingActionButton: refreshDataList(context),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Borrar partidas'),
                          content: const Text(
                            '¿Quieres eliminar todas las partidas del día de hoy?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Perform delete operation here
                                DateTime today = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                );
                                matchProvider.deleteByDate(today);
                                setState(() {
                                  futureMatches = matchProvider.readAll();
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sí'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Borrar partidas'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Call the delete match function
                      showDialog(
                        context: context,
                        builder: (context) => CreateReportDialog(),
                      );
                    },
                    child: const Text('Crear informe'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  FutureBuilder<List<Match>> matchList() {
    // FIXME: Mostrar solo las partidas sin informe?
    // Así evitamos borrar partidas relacionadas
    // (No pasaría nada por borrarlas, pero igual suena un poco raro que un
    //  informe hable de partidas que no están almacenadas en ningún sitio)
    return FutureBuilder<List<Match>>(
      future: futureMatches,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final matches = snapshot.data!;

          return matches.isEmpty
              ? const Center(
                  child: Text(
                    "No hay partidas",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final match = matches[index];

                    return ListTile(
                      title: Text(
                        "gameId: ${match.gameId.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Duration: ${match.duration.toString()}"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowMatchInfo(match: match),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_forever,
                            color: Colors.redAccent),
                        onPressed: () {
                          matchProvider.delete(match.id!);
                          setState(() {
                            futureMatches = matchProvider.readAll();
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: matches.length,
                );
        }
      },
    );
  }

  FutureBuilder<List<Game>> gameList() {
    return FutureBuilder<List<Game>>(
      future: futureGames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final games = snapshot.data!;

          return games.isEmpty
              ? const Center(
                  child: Text(
                    "No hay juegos",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final game = games[index];

                    return ListTile(
                      title: Text(
                        game.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowGameInfo(game: game),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: games.length,
                );
        }
      },
    );
  }

  FutureBuilder<List<Report>> reportList() {
    return FutureBuilder<List<Report>>(
      future: futureReports,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final reports = snapshot.data!;

          return reports.isEmpty
              ? const Center(
                  child: Text(
                    "No hay informes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final report = reports[index];

                    return ListTile(
                      title: Text(
                        "userName: ${report.userName.toString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("id: ${report.id.toString()}"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowReportInfo(report: report),
                        );
                      },
                      trailing: IconButton(
                        onPressed: () async {
                          // Generate pdf data
                          final Map<String, dynamic> reportBuild =
                              await pdfReportService.buildReport(
                            report: report,
                          );

                          // Generate pdf
                          final Uint8List data =
                              await pdfReportService.createDocument(
                            data: reportBuild,
                          );

                          // Save and open file in device
                          pdfReportService.savePdfFile(
                            fileName:
                                "${reportBuild['date']}_${reportBuild['name']}",
                            data: data,
                          );
                        },
                        icon: const Icon(
                          Icons.picture_as_pdf,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: reports.length,
                );
        }
      },
    );
  }

  FloatingActionButton refreshDataList(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.refresh),
      onPressed: () {
        readAll();
      },
    );
  }
}

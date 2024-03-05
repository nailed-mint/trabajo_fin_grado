import 'package:flutter/material.dart';
import 'package:tfg_redesign/models/game.dart';
import 'package:tfg_redesign/models/match.dart';
import 'package:tfg_redesign/models/report.dart';
import 'package:tfg_redesign/models/user.dart';
import 'package:tfg_redesign/providers/user_provider.dart';
import 'package:tfg_redesign/providers/game_provider.dart';
import 'package:tfg_redesign/providers/match_provider.dart';
import 'package:tfg_redesign/providers/report_provider.dart';
import 'package:tfg_redesign/widgets/create_user_dialog.dart';
import 'package:tfg_redesign/widgets/show_game_info.dart';
import 'package:tfg_redesign/widgets/show_match_dialog.dart';
import 'package:tfg_redesign/widgets/show_report_dialog.dart';
import 'package:tfg_redesign/widgets/sidenav_drawer.dart';

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  Future<List<User>>? futureUsers;
  Future<List<Game>>? futureGames;
  Future<List<Match>>? futureMatches;
  Future<List<Report>>? futureReports;
  final userProvider = UserProvider();
  final gameProvider = GameProvider();
  final matchProvider = MatchProvider();
  final reportProvider = ReportProvider();

  @override
  void initState() {
    super.initState();

    readAll();
  }

  void readAll() {
    setState(() {
      futureUsers = userProvider.readAll();
      futureGames = gameProvider.readAll();
      futureMatches = matchProvider.readAll();
      futureReports = reportProvider.readAll();
    });
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          drawer: const SidenavDrawer(),
          appBar: AppBar(
            title: const Text('Visualización de Datos'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.person),
                ),
                Tab(
                  icon: Icon(Icons.gamepad),
                ),
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
                child: userList(),
              ),
              Center(
                child: gameList(),
              ),
              Center(
                child: matchList(),
              ),
              Center(
                child: reportList(),
              ),
            ],
          ),
          floatingActionButton: createUserButton(context),
        ),
      );

  FutureBuilder<List<User>> userList() {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final users = snapshot.data!;

          return users.isEmpty
              ? const Center(
                  child: Text(
                    "No hay usuarios",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final subtitle = user.type;

                    return ListTile(
                      title: Text(
                        user.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(subtitle.toString()),
                      trailing: IconButton(
                        onPressed: () async {
                          await userProvider.delete(user.id!);
                          readAll();
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CreateUserWidget(
                            user: user,
                            onSubmit: (name, type) async {
                              await userProvider.update(
                                user: User(
                                  id: user.id,
                                  name: name,
                                  type: type,
                                  email: user.email,
                                ),
                              );
                              readAll();
                              if (!mounted) return;
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: users.length,
                );
        }
      },
    );
  }

  FutureBuilder<List<Match>> matchList() {
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
                        match.gameId.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(match.duration.toString()),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowMatchInfo(match: match),
                        );
                      },
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
                        report.userId.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(report.id.toString()),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ShowReportInfo(report: report),
                        );
                      },
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

  FloatingActionButton createUserButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => CreateUserWidget(
            onSubmit: (name, type) async {
              await userProvider.create(
                user: User(
                  name: name,
                  type: type,
                ),
              );
              if (!mounted) return;
              readAll();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

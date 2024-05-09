import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/models/game.dart';
import 'package:trabajo_fin_grado/providers/game_provider.dart';
import 'package:trabajo_fin_grado/services/arasaac_service.dart';
import 'package:trabajo_fin_grado/widgets/show_game_info.dart';
import 'package:trabajo_fin_grado/widgets/sidenav_drawer.dart';

class GameSelector extends StatefulWidget {
  const GameSelector({super.key});

  @override
  State<GameSelector> createState() => _GameSelectorState();
}

class _GameSelectorState extends State<GameSelector> {
  Future<List<Game>>? futureGames;
  final gameProvider = GameProvider();

  @override
  void initState() {
    super.initState();

    readGames();
  }

  void readGames() {
    setState(() {
      futureGames = gameProvider.readAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const SidenavDrawer(),
        appBar: AppBar(
          title: const Text("Elige un Juego"),
        ),
        body: Center(
          child: gameList(),
        ),
      );

  FutureBuilder<List<Game>> gameList() {
    return FutureBuilder<List<Game>>(
      future: futureGames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            // Handle the error appropriately.
            // For example, you might want to show an error message.
            return Text('An error occurred: ${snapshot.error}\n');
          }

          List? data = snapshot.data;
          data ??= [];
          final games = data;

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
                      leading: ArasaacService.getPictogram(icon: game.icon),
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
}

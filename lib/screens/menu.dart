import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:trabajo_fin_grado/games/spot_the_difference_launcher.dart';
import 'package:trabajo_fin_grado/widgets/close_dialog.dart';
import 'package:trabajo_fin_grado/widgets/expanded_button.dart';
import 'package:trabajo_fin_grado/widgets/info_page.dart';
import 'package:trabajo_fin_grado/widgets/instructions_page.dart';

/// This widget displays a menu with buttons that navigate to different pages.
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final logger = Logger();

  late String barTitle = "Menu";
  late int length = 0;
  late Map<String, dynamic> profiles = {};
  late Map<String, dynamic> currentProfile = {};
  late List<String> previousProfile = [];

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  @override
  Widget build(BuildContext context) {
    logger.d("current profile: $currentProfile\n"
        "current profile length: $length\n"
        "previous profile: $previousProfile");

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            barTitle,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: previousProfile.isNotEmpty
            ? IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  _updateProfile(previousProfile.removeLast(), goingBack: true);
                })
            : IconButton(
                onPressed: () {
                  _updateProfile("info");
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 30,
                )),
      ),
      body: Column(
        children: List.generate(
          length,
          (index) => ExpandedButton(
            buttonText: currentProfile['buttonTexts'][index].toString(),
            imageUrl: currentProfile['imageUrls'][index],
            nextPage: () => _updateProfile(currentProfile['nextPages'][index]),
          ),
        ),
      ),
    );
  }

  // PRIVATE METHODS ===========================================================

  /// Loads the JSON data from the assets folder and sets the initial state of the widget.
  Future<void> _loadJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/menu_profiles.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      profiles = jsonMap;
      currentProfile = profiles['menu'];
      length = currentProfile['buttonTexts'].length;
    });
  }

  /// Updates the current profile to the one specified by [newProfile].
  ///
  /// If [goingBack] is true, the previous profile is restored instead of the
  /// specified profile.
  void _updateProfile(String newProfile, {bool goingBack = false}) {
    logger.d("new profile: $newProfile\npreviousProfile: $previousProfile");
    switch (newProfile) {
      case "close":
        showDialog(
          context: context,
          builder: (BuildContext context) => const CloseDialog(),
        );
        break;
      case "instructions":
        showDialog(
          context: context,
          builder: (BuildContext context) => const InstructionsPage(),
        );
        break;
      case "info":
        showDialog(
          context: context,
          builder: (BuildContext context) => const InfoPage(),
        );
      case "spotTheDifferenceGame":
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SpotTheDifferenceLauncher(
              title: 'Spot The Difference',
            ),
          ),
        );
        break;
      default:
        setState(() {
          !goingBack ? previousProfile.add(currentProfile['name']) : null;
          currentProfile = profiles[newProfile];
          length = currentProfile['buttonTexts'].length;
        });
    }
  }
}

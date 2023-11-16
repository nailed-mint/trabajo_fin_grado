import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:trabajo_fin_grado/games/spot_the_difference/spot_the_difference.dart';
import 'package:trabajo_fin_grado/menu/widgets/close_dialog.dart';
import 'package:trabajo_fin_grado/menu/widgets/expanded_button.dart';
import 'package:trabajo_fin_grado/menu/widgets/info_page.dart';
import 'package:trabajo_fin_grado/menu/widgets/instructions_page.dart';

/// A StatefulWidget that displays a menu with different profiles.
class MenuPage extends StatefulWidget {
  /// Creates a new instance of MenuPage.
  const MenuPage({super.key});

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<MenuPage> createState() => _MenuPageState();
}

/// The logic and internal state for a StatefulWidget.
class _MenuPageState extends State<MenuPage> {
  /// Logger instance to log debug information.
  final logger = Logger();

  /// The title of the AppBar.
  late String barTitle = "Menu";

  /// The length of the profiles list.
  late int length = 0;

  /// The profiles available in the menu.
  late Map<String, dynamic> profiles = {};

  /// The current profile selected in the menu.
  late Map<String, dynamic> currentProfile = {};

  /// The previous profile selected in the menu.
  late List<String> previousProfile = [];

  /// Called when this object is inserted into the tree.
  ///
  /// The framework will call this method exactly once for each [State] object it creates.
  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  /// Builds the widget.
  ///
  /// Displays a Scaffold with an AppBar and a Column. The AppBar title is set to the current profile name. The AppBar leading icon changes depending on whether there is a previous profile or not. The Column displays the profiles available in the menu.
  @override
  Widget build(BuildContext context) {
    logger.d("current profile: $currentProfile\n"
        "current profile length: $length\n"
        "previous profile: $previousProfile");

    return Scaffold(
      appBar: AppBar(
        /// The title of the AppBar.
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

                /// The leading icon of the AppBar when there is a previous profile.
                ///
                /// When pressed, the profile is updated to the previous one.
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  _updateProfile(previousProfile.removeLast(), goingBack: true);
                })
            : IconButton(
                onPressed: () {
                  _updateProfile("info");
                },

                /// The leading icon of the AppBar when there is no previous profile.
                ///
                /// When pressed, the profile is updated to the info profile.
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                  size: 30,
                )),
      ),
      body: Column(
        /// Generates a list of ExpandedButton widgets for each profile.
        children: List.generate(
          length,
          (index) => ExpandedButton(
            /// The text to be displayed on the button.
            buttonText: currentProfile['buttonTexts'][index].toString(),

            /// The URL of the image to be displayed on the button.
            imageUrl: currentProfile['imageUrls'][index],

            /// The function to be executed when the button is pressed.
            nextPage: () => _updateProfile(currentProfile['nextPages'][index]),
          ),
        ),
      ),
    );
  }

  // PRIVATE METHODS ===========================================================

  /// Loads the JSON data from the assets folder and sets the initial state of the widget.
  Future<void> _loadJson() async {
    /// The JSON string loaded from the assets folder.
    final String jsonString =
        await rootBundle.loadString('assets/menu_profiles.json');

    /// The JSON map decoded from the JSON string.
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      /// The profiles available in the menu.
      profiles = jsonMap;

      /// The current profile selected in the menu.
      currentProfile = profiles['menu'];

      /// The length of the profiles list.
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

        /// Displays a dialog asking the user if they want to close the application.
        showDialog(
          context: context,
          builder: (BuildContext context) => const CloseDialog(),
        );
        break;
      case "instructions":

        /// Displays a dialog with the instructions for the application.
        showDialog(
          context: context,
          builder: (BuildContext context) => const InstructionsPage(),
        );
        break;
      case "info":

        /// Displays a dialog with the information about the application.
        showDialog(
          context: context,
          builder: (BuildContext context) => const InfoPage(),
        );
      case "spotTheDifferenceGame":

        /// Navigates to the SpotTheDifferenceLauncher page.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SpotTheDifference(),
          ),
        );
        break;
      default:

        /// Updates the state of the widget to the new profile.
        setState(() {
          !goingBack ? previousProfile.add(currentProfile['name']) : null;
          currentProfile = profiles[newProfile];
          length = currentProfile['buttonTexts'].length;
        });
    }
  }
}

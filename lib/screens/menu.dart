import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trabajo_fin_grado/widgets/expanded_button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';

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
  late Map<String, dynamic> previousProfile = {};

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/profiles.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      profiles = jsonMap;
      currentProfile = profiles['menu'];
      length = currentProfile['buttonTexts'].length;
    });
  }

  void updateProfile(String newProfile) {
    setState(() {
      previousProfile = currentProfile;
      currentProfile = profiles[newProfile];
      length = currentProfile['buttonTexts'].length;
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d(
        "current profile: $currentProfile \n current profile length: $length \n previous profile: $previousProfile");

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(barTitle,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        backgroundColor: Theme.of(context).primaryColor,
        leading: currentProfile['name'] != 'menu'
            ? IconButton(
                icon: const Icon(Icons.home, color: Colors.white, size: 30),
                onPressed: () => updateProfile('menu'),
              )
            : null,
      ),
      body: Column(
        children: List.generate(
          length,
          (index) => ExpandedButton(
            buttonText: currentProfile['buttonTexts'][index].toString(),
            imageUrl: currentProfile['imageUrls'][index],
            nextPage: () => updateProfile(currentProfile['nextPages'][index]),
          ),
        ),
      ),
    );
  }
}

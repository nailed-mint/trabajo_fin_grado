import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Loads the JSON data from the assets folder and sets the initial state of the widget.
Future<Map<String, dynamic>> loadJson({required String path}) async {
  final String jsonString = await rootBundle.loadString(path);
  return json.decode(jsonString);
}

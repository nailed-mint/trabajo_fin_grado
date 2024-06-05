import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Loads and decodes a JSON file from the given [path].
///
/// This method reads a JSON file as a string from the provided [path] using the
/// `rootBundle.loadString` method, then decodes the JSON string into a
/// `Map<String, dynamic>` using the `json.decode` method.
///
/// The [path] parameter is required and should be a string representing the
/// path to the JSON file.
///
/// Returns a `Future<Map<String, dynamic>>` that completes with the decoded
/// JSON data.
///
/// Throws an exception if the file at the specified [path] cannot be read or if
/// the data cannot be decoded into JSON.
Future<Map<String, dynamic>> loadJson({required String path}) async {
  final String jsonString = await rootBundle.loadString(path);
  return json.decode(jsonString);
}

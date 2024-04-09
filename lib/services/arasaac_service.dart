import 'package:flutter/material.dart';

class ArasaacService {
  static const String baseUrl = "https://api.arasaac.org/api/pictograms/";

  static Image getPictogram({required int icon}) {
    return Image(
      image: NetworkImage(baseUrl + icon.toString()),
      fit: BoxFit.contain,
    );
  }
}

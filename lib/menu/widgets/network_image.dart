import 'package:flutter/material.dart';

/// A StatelessWidget that displays an image from a network source.
///
/// The image is loaded from a predefined server URL, with the specific image URL passed as a parameter.
class NetImage extends StatelessWidget {
  /// The base URL of the server where the images are hosted.
  final String serverUrl = "https://api.arasaac.org/api/pictograms/";

  /// The specific URL of the image to be displayed.
  final String imageUrl;

  /// Creates a new instance of NetImage.
  ///
  /// Requires the specific image URL as a parameter.
  const NetImage({super.key, required this.imageUrl});

  /// Builds the widget.
  ///
  /// Displays the image from the network source, and shows a loading spinner while the image is loading.
  @override
  Widget build(BuildContext context) {
    return Image.network(
      serverUrl + imageUrl,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Text('Fallo al cargar imagen');
      },
    );
  }
}

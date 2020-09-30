import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/// Shows a single photo and enables it to be zoomed and panned.
class PhotoScreen extends StatelessWidget {
  final PhotoScreenArguments arguments;

  const PhotoScreen(this.arguments, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      behavior: HitTestBehavior.translucent,
      child: PhotoView(
        // minScale: 1.0,
        backgroundDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
        ),
        customSize: MediaQuery.of(context).size,

        minScale: PhotoViewComputedScale.contained * 0.9,
        maxScale: PhotoViewComputedScale.covered * 2,
        heroAttributes: PhotoViewHeroAttributes(tag: arguments.photoUrl),
        imageProvider: AssetImage(arguments.photoUrl),
      ),
    );
  }
}

/// Contains arguments for PhotoScreen.
class PhotoScreenArguments {
  // Url of the photo that has to be shown.
  final String photoUrl;

  PhotoScreenArguments(this.photoUrl);
}

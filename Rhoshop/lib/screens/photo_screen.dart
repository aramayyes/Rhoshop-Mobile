import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;

/// Shows a single photo and enables it to be zoomed and panned.
class PhotoScreen extends StatelessWidget {
  final PhotoScreenArguments arguments;

  const PhotoScreen(this.arguments, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.black.withOpacity(0.7);

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      behavior: HitTestBehavior.translucent,
      child: PhotoView(
        // minScale: 1.0,
        backgroundDecoration: BoxDecoration(
          color: backgroundColor,
        ),
        customSize: MediaQuery.of(context).size,
        minScale: PhotoViewComputedScale.contained * 0.9,
        maxScale: PhotoViewComputedScale.covered * 2,
        heroAttributes: PhotoViewHeroAttributes(tag: arguments.photoUrl),
        imageProvider: NetworkImage(arguments.photoUrl),
        loadingBuilder: (context, progress) => Container(
          color: backgroundColor,
          child: Center(
            child: Container(
              width: 60.0,
              height: 60.0,
              child: CircularProgressIndicator(
                  value: progress == null
                      ? null
                      : progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(AppColors.secondary)),
            ),
          ),
        ),
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ImageView extends StatefulWidget {
  final imageUrl;
  ImageView({
    @required this.imageUrl,
    Key key,
  }) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: '${widget.imageUrl}',
            child: Container(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(widget.imageUrl),
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 35.0,
                left: 15.0,
                // right: 15.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(FlutterIcons.cross_ent),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

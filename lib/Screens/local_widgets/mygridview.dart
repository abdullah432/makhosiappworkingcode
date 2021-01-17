import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyGridView extends StatelessWidget {
  final List<String> contentList;
  final Function(String) onPressed;

  const MyGridView({
    @required this.contentList,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 0.8,
      children: List.generate(contentList?.length ?? 0, (index) {
        final url = contentList[index];
        return GestureDetector(
          onTap: () => onPressed(url),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Hero(
                tag: url,
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.cover,
                  placeholder: (context, string) =>
                      Center(child: CircularProgressIndicator()),
                ),
              )),
        );
      }),
    );
  }
}

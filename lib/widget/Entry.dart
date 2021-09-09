import 'package:flutter/material.dart';
import 'package:flutters/model/BooruImage.dart';

class Entry extends StatelessWidget {
  final BooruImage image;

  const Entry(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Image.network(image.representations.thumbSmall, fit: BoxFit.contain),
    );
  }
}

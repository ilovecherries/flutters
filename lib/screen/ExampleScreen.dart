import 'package:flutter/material.dart';
import 'package:flutters/model/BooruImage.dart';
import 'package:flutters/util/RequestBuilder.dart';
import 'package:flutters/widget/Entry.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final booru = BooruHTTPClient('www.derpibooru.org', false);

    return Scaffold(
        body: FutureBuilder<List<BooruImage>>(
      future: booru.searchImages([]),
      builder:
          (BuildContext context, AsyncSnapshot<List<BooruImage>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: snapshot.data!.map((e) => new Entry(e)).toList(),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("data");
        } else {
          return Text("data");
        }
      },
    ));
  }
}

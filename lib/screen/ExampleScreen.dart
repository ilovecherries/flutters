import 'package:flutter/material.dart';
import 'package:flutters/model/BooruImage.dart';
import 'package:flutters/util/RequestBuilder.dart';
import 'package:flutters/widget/Entry.dart';
import 'package:http/http.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final http = BooruHTTPClient(Client());

    return Scaffold(
        body: FutureBuilder<BooruImage>(
      future: http.getImageById(2606782),
      builder: (BuildContext context, AsyncSnapshot<BooruImage> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Entry(snapshot.data!);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("data");
        } else {
          return Text("data");
        }
      },
    ));
  }
}

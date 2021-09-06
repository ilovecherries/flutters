import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutters/model/BooruImage.dart';
import 'package:flutters/util/RequestBuilder.dart';
import 'package:flutters/widget/Entry.dart';
import 'package:http/http.dart';

class ExampleScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final http = BooruHTTPClient(Client());
    var loaded = useState(false);
    BooruImage? image;

    print('?????');

    refresh() async {
      print('hello there!!!!');
      image = await http.getImageById(20);
      loaded.value = true;
      print("${image?.name}");
    }

    useEffect(() {
      refresh();
      return;
    }, const []);

    return Center(child: loaded.value ? null : Entry(image!));
  }
}

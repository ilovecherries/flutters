import 'dart:convert';

import 'package:flutters/model/BooruImage.dart';
import 'package:http/http.dart'
    show BaseClient, Client, Request, Response, BaseRequest, StreamedResponse;
// import 'package:es_compression/brotli.dart';

final defaultBoorus = [
  'www.derpibooru.org',
  'www.ponerpics.org',
  'www.twibooru.org',
];

class BooruHTTPClient extends BaseClient {
  final String userAgent = 'flutters/0.0';
  final String acceptEncoding = 'gzip';
  final Client _inner;
  final String host = defaultBoorus[0];
  String get referer => "https://$host/";
  final String apiPath = 'api/v1/json';

  String get api => "$referer$apiPath";

  BooruHTTPClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    request.headers['accept-encoding'] = acceptEncoding;
    request.headers['host'] = host;
    request.headers['referer'] = referer;
    return _inner.send(request);
  }

  Future<BooruImage> getImageById(int id) async {
    final uri = Uri.parse("$api/images/$id");
    final request = Request('GET', uri);

    final resp = await Response.fromStream(await send(request));
    final encoding = resp.headers['content-encoding'];
    print('encoding: $encoding'); //gzip, zlib already covered by http.dart
    String respBody = resp.body;

    final json = jsonDecode(respBody);
    final image = BooruImage.fromJson(json['image']);

    return image;
  }

  Future<List<BooruImage>> searchImages(List<String> tags,
      [int page = 0]) async {
    // this is a nice default value
    if (tags.isEmpty) {
      tags.add('safe');
    }

    final tagString = tags.join(',');
    final uri = Uri.parse("$api/search/images/?p=$page&q=$tagString");
    final request = Request('GET', uri);

    final resp = await Response.fromStream(await send(request));
    final encoding = resp.headers['content-encoding'];
    print('encoding: $encoding'); //gzip, zlib already covered by http.dart
    String respBody = resp.body;

    final json = jsonDecode(respBody)['images'] as List<dynamic>;
    final images = json.map((i) => BooruImage.fromJson(i)).toList();

    return images;
  }
}

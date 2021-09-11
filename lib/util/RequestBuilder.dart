import 'dart:convert';

import 'package:flutters/model/BooruImage.dart';
import 'package:http/http.dart'
    show BaseClient, Client, Request, Response, BaseRequest, StreamedResponse;

final defaultBoorus = [
  'www.derpibooru.org',
  'www.ponerpics.org',
  'www.twibooru.org',
];

class BooruHTTPClient extends BaseClient {
  final String userAgent = 'flutters/0.0';
  final String acceptEncoding = 'gzip';
  final Client _inner;
  final String host;
  String get favicon =>
      'https://s2.googleusercontent.com/s2/favicons?domain=$host';
  String get referer => "https://$host/";
  final String apiPath = 'api/v1/json';
  final bool relativeURLPathing;

  String get api => "$referer$apiPath";

  BooruHTTPClient(this.host, this.relativeURLPathing) : _inner = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    request.headers['accept-encoding'] = acceptEncoding;
    request.headers['host'] = host;
    request.headers['referer'] = referer;
    return _inner.send(request);
  }

  Future<dynamic> getJSON(String path) async {
    final uri = Uri.parse("$api/$path");
    final request = Request('GET', uri);

    final resp = await Response.fromStream(await send(request));
    String respBody = resp.body;

    return jsonDecode(respBody);
  }

  Future<BooruImage> getImageById(int id) async {
    final json = await getJSON("images/$id");
    final image = BooruImage.fromJson(
        json['image'], relativeURLPathing ? 'https://$host' : '');

    return image;
  }

  Future<List<BooruImage>> searchImages(List<String> tags,
      [int page = 1]) async {
    // this is a nice default value
    if (tags.isEmpty) {
      tags.add('safe');
    }

    final json = await getJSON("search/images/?page=$page&q=${tags.join(',')}");
    final data = json['images'] as List<dynamic>;
    final url = relativeURLPathing ? 'https://$host' : '';
    final images = data.map((i) => BooruImage.fromJson(i, url)).toList();

    return images;
  }
}

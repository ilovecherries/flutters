import 'dart:convert';

import 'package:brotli/brotli.dart';
import 'package:flutters/model/BooruImage.dart';
import 'package:http/http.dart' show BaseClient, Client, Request, Response;
import 'package:http/src/streamed_response.dart';
import 'package:http/src/base_request.dart';

class BooruHTTPClient extends BaseClient {
  final String userAgent = 'flutters/0.0';
  final String acceptEncoding = 'gzip, br';
  final Client _inner;
  // TODO: this is fucking awful, this will be bad when we have altboorus
  final String host = 'www.derpibooru.org';
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
    String respBody;
    switch (encoding) {
      case 'br':
        respBody = utf8.decode(brotli.decodeToString(resp.bodyBytes).codeUnits);
        break;
      default:
        respBody = resp.body;
    }

    final json = jsonDecode(respBody);
    final image = BooruImage.fromJson(json);

    return image;
  }
}

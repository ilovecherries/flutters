import 'dart:convert';

import 'package:flutters/model/BooruImage.dart';
import 'package:http/http.dart'
    show BaseClient, Client, Request, Response, BaseRequest, StreamedResponse;
// import 'package:es_compression/brotli.dart';

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
    String respBody = resp.body;

    // FIXME: This is commented out because the Linux brotli library is not
    // available for es_compression for some reason...
    // switch (encoding) {
    //   case 'br':
    //     // respBody = utf8.decode(brotli.decodeToString(resp.bodyBytes).codeUnits);
    //     respBody = utf8.decode(brotli.decode(resp.bodyBytes));
    //     break;
    //   default:
    //     respBody = resp.body;
    // }

    final json = jsonDecode(respBody);
    final image = BooruImage.fromJson(json['image']);

    return image;
  }
}

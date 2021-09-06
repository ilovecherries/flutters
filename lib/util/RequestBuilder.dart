import 'package:http/http.dart' show BaseClient;
import 'package:http/src/streamed_response.dart';
import 'package:http/src/base_request.dart';

class BooruHTTPClient extends BaseClient {
	final String userAgent = 'flutters/0.0';
  	
	@override
	Future<StreamedResponse> send(BaseRequest request) {
		// TODO: implement send
		throw UnimplementedError();
	}
}

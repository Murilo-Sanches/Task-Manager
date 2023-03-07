import 'package:http/http.dart' as http;

class Fetch {
  static dynamic get({required Map body, required String url}) {}

  static dynamic post({
    String? url,
    required Map body,
  }) async {
    print(_validateUrl(url));
    return await http.post(Uri.http(_validateUrl(url)), body: body);

    // return res;
  }

  static dynamic put({required Map body, required String url}) {}

  static dynamic patch({required Map body, required String url}) {}

  static dynamic delete({required Map body, required String url}) {}

  static String _validateUrl(String? url) {
    return url!.isEmpty ? url : 'localhost:5555';
  }
}

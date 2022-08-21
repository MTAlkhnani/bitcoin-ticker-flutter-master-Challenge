import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Uri uri;
  NetworkHelper(this.uri);

  Future getData() async {
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}

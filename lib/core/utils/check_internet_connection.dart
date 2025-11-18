import 'package:http/http.dart' as http;

Future<bool> checkInternetConnection() async {
  try {
    final response = await http.get(Uri.parse('https://www.google.com'))
        .timeout(Duration(seconds: 5));
    if (response.statusCode == 200) return true;
    return false;
  } catch (_) {
    return false;
  }
}

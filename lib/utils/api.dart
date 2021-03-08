import 'dart:async';
import 'package:http/http.dart' as http;

class API {
  static Future getUsers() {
    return http.get(Uri.https('jsonplaceholder.typicode.com', '/users'),
        headers: {"Accept": "application/json"});
  }

  static Future getBooks() async {
    try {
      http.Response response = await http.get(
          Uri.https('api.nytimes.com',
              '/svc/books/v3/lists/overview.json?api-key=bcV7UTIYY5JPv4T9GEtWVkrin5S8GoBP'),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        return response;
      } else {
        print(response.body);
        throw Exception('Failed to get books');
      }
    } catch (error) {
      print(error);
      return error;
    }
  }
}

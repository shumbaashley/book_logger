import 'dart:async';
import 'package:http/http.dart' as http;


class API {
  static Future getUsers() {
    return http.get(Uri.https('jsonplaceholder.typicode.com', '/users'), headers: {"Accept": "application/json"});;
  }
}

        

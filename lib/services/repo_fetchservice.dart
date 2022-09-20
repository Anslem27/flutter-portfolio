import 'dart:convert';

import 'package:flutter_portfolio/models/git_model.dart';
import 'package:http/http.dart' as http;

Future<AllRepos> fetchRepos() async {
  var url = Uri.https('api.github.com', 'users/Anslem27/repos');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // print(response.body);
    return AllRepos.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch repos');
  }
}

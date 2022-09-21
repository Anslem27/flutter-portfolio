import 'dart:convert';

import 'package:flutter_portfolio/models/git_models.dart';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:http/http.dart' as http;

//fetch Repos
Future<AllRepos> fetchRepos() async {
  var url =
      Uri.https('api.github.com', 'users/${Constants.githubUserName}/repos');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // print(response.body);
    return AllRepos.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch repos');
  }
}

//Fetch User Info

Future<GithubUser> fetchGitUser() async {
  var url = Uri.https('api.github.com', 'users/${Constants.githubUserName}');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    print(response.body);
    return GithubUser.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch repos');
  }
}

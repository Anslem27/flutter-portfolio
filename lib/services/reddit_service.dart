import 'dart:convert';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../models/reddit_model.dart';

Future<Data?> fetchRedditInfo() async {
  var url = Uri.https(
      'www.reddit.com', 'user/${Constants.redditUserName}/about.json');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // print(response.body);
    return RedditModel.fromJson(json.decode(response.body)).data;
  } else {
    throw Exception('Failed to fetch repos');
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/model/now_playing_model.dart';

// ignore: camel_case_types
class nowPlayingGetData {
  var url = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=c94a1059b23db6440e15715367c26e37');
  Future<NowPlaying> fetchData() async {
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer c94a1059b23db6440e15715367c26e37"
    });

    if (response.statusCode == 200) {
      //print(response.body);
      return NowPlaying.fromJson(json.decode(response.body));
    } else {
      // ignore: avoid_print
      print(response.statusCode);
      throw Exception('Failed to load');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/movies_model.dart';

// ignore: camel_case_types
class nowPlaying {
  var url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200&api_key=c94a1059b23db6440e15715367c26e37');
  Future<MoviesModel> verileriCek() async {
    var response = await http.get(url, headers: {
      'Content-type': 'application/json',
      "accept": "application/json",
      "Authorization": "Bearer c94a1059b23db6440e15715367c26e37"
    });
    

    if (response.statusCode == 200) {
      return MoviesModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  
}

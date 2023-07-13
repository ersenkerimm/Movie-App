import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movies/class/now_playing_get_data.dart';
import 'package:movies/model/movies_model.dart';
import 'package:movies/model/now_playing_model.dart';
import 'package:movies/movie_details_page/movie_details.dart';
import 'package:movies/movie_details_page/now_playing_details.dart';

class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  nowPlayingGetData getData = nowPlayingGetData();
  late final Future<MoviesModel> _cek;

  @override
  void initState() {
    super.initState();
    _cek = veriCek();
  }

  var url = Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200&api_key=c94a1059b23db6440e15715367c26e37');
  Future<MoviesModel> veriCek() async {
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

  ///
  var urla = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=c94a1059b23db6440e15715367c26e37');
  Future<NowPlaying> fetchData() async {
    var response = await http.get(urla, headers: {
      'Content-type': 'application/json',
      "accept": "application/json",
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOTRhMTA1OWIyM2RiNjQ0MGUxNTcxNTM2N2MyNmUzNyIsInN1YiI6IjY0YTZkMGFmNzI0ZGUxMDBhY2E2YzVlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RbnFcH_WS4gdlc5U01MR3BZns2-RK2PvrW3F7UceamQ'
    });

    if (response.statusCode == 200) {
      // print(response.body);
      return NowPlaying.fromJson(json.decode(response.body));
    } else {
      //print('hata');
      throw Exception('Failed to load');
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Movies"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8),
                child: Text("Top Rated Movies",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 15),
              FutureBuilder<MoviesModel>(
                  future: _cek,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        height: 320,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildContainer(snapshot),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Hata");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 8),
                child: Text("Now Playing",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 15),
              FutureBuilder<NowPlaying>(
                  
                  future: getData.fetchData(),
                  builder: (context, AsyncSnapshot<NowPlaying> snapshot) {
                    if (snapshot.hasData) {
                      
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 10, right: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 550,
                          child: ListView.builder(
                           
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowPlayingDetails(
                                          snapshot.data!.results![index]),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: ClipRRect(
                                         
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                              "https://image.tmdb.org/t/p/original${snapshot.data!.results![index].posterPath}"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        flex: 8,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: 275,
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!
                                                        .results![index].title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .results![index]
                                                        .releaseDate
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        size: 15,
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .results![index]
                                                            .voteAverage
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.amber,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshot.data!.results!.length,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // ignore: avoid_print
                      print(snapshot.error);
                      return const Text(
                        "Error",
                        style: TextStyle(color: Colors.amber),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ));
  }

  ListView buildContainer(AsyncSnapshot<MoviesModel> snapshot) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetails(snapshot.data!.results![index]),
                  ),
                );
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 300,
                  maxHeight: 300,
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  maxWidth: MediaQuery.of(context).size.width * 0.4,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.network(
                                "https://image.tmdb.org/t/p/original${snapshot.data!.results![index].posterPath}"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  Text(
                                    snapshot.data!.results![index].voteAverage
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.amber, fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          snapshot.data!.results![index].title.toString(),
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
        itemCount: snapshot.data!.results!.length);
  }
}

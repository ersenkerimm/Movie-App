import 'package:flutter/material.dart';
import 'package:movies/class/now_playing_get_data.dart';
import 'package:movies/model/now_playing_model.dart';
import 'package:movies/movie_details_page/now_playing_details.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  nowPlayingGetData getData = nowPlayingGetData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NowPlaying>(
          future: getData.fetchData(),
          builder: (context, AsyncSnapshot<NowPlaying> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                height: 320,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NowPlayingDetails(
                                      snapshot.data!.results![index]),
                                ),
                              );
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 300,
                                maxHeight: 300,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.4,
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
                                                  snapshot.data!.results![index]
                                                      .voteAverage
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.amber,
                                                      fontSize: 14),
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
                                        snapshot.data!.results![index].title
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.results!.length,
                    )),
              );
            } else if (snapshot.hasError) {
              // ignore: avoid_print
              print(snapshot.error);
              return const Text(
                "Hata",
                style: TextStyle(color: Colors.amber),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

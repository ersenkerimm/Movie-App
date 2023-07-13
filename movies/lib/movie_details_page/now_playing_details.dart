import 'package:flutter/material.dart';
import 'package:movies/class/now_playing_get_data.dart';
import 'package:movies/model/now_playing_model.dart';

// ignore: must_be_immutable
class NowPlayingDetails extends StatefulWidget {
  Results data;
  NowPlayingDetails(this.data, {super.key});

  @override
  State<NowPlayingDetails> createState() => _NowPlayingDetailsState();
}

class _NowPlayingDetailsState extends State<NowPlayingDetails> {
  nowPlayingGetData getData = nowPlayingGetData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<NowPlaying>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    alignment: Alignment.topCenter,
                                    opacity: 2,
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original${widget.data.backdropPath}"))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: IconButton(
                                color: Colors.amber,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_ios_new)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 180.0),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(36)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/original${widget.data.posterPath}"))),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 230.0, left: 140),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                widget.data.title.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24.0, top: 20),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          widget.data.overview.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text("hata");
              } else {
                return const CircularProgressIndicator();
              }
            },
            future: getData.fetchData()));
  }
}

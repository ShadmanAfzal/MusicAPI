import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/music_bloc.dart';
import '../models/music_model.dart';
import 'music_detail.dart';
import 'music_playlist.dart';

class MusicList extends StatefulWidget {
  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  var subscription;
  bool isConnected = true;
  @override
  void initState() {
    super.initState();
    checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        isConnected = result == ConnectivityResult.none ? false : true;
        if (isConnected) {
          bloc.fetchAllMusic();
        }
      });
    });
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        bloc.fetchAllMusic();
        isConnected = true;
      });
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isConnected ? Colors.transparent : Colors.white,
      appBar: AppBar(
        title: Text('Popular Music'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MusicPlaylist();
                }),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                Icons.playlist_play,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: isConnected
          ? StreamBuilder(
              stream: bloc.allMusic,
              builder: (context, AsyncSnapshot<MusicModel> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot);
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            )
          : Center(
              child: Text(
              'No Internet Connection',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 20,
              ),
            )),
    );
  }

  Widget buildList(AsyncSnapshot<MusicModel> snapshot) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      itemCount: snapshot.data.results.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        ///Return Single Widget
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MusicDetail(
                  trackId: snapshot.data.results[index].trackId,
                  trackName: snapshot.data.results[index].trackName,
                  albumName: snapshot.data.results[index].albumName,
                  artistName: snapshot.data.results[index].artistName,
                );
              }),
            );
          },
          child: Card(
            elevation: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 12,
                  ),
                  Icon(
                    Icons.library_music,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data.results[index].trackName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '- (${snapshot.data.results[index].albumName})',
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Artist - ${snapshot.data.results[index].artistName}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

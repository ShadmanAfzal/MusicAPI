import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/music_detail_bloc.dart';
import '../blocs/music_detail_track_block.dart';
import '../models/music_detail_model.dart';
import '../models/music_detail_track_model.dart';

class MusicDetail extends StatefulWidget {
  final int trackId;
  final String trackName;
  final String albumName;
  final String artistName;
  final int index;

  MusicDetail({
    this.trackId,
    this.trackName,
    this.albumName,
    this.artistName,
    this.index,
  });

  @override
  _MusicDetailState createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  SharedPreferences sharedPreferences;
  var subscription;
  bool isBookmarked = false;
  List<String> bookmarkedTracks = [];

  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.light ? Colors.white : theme.cardColor,
      appBar: AppBar(
        title: Text('Popular Music'),
      ),
      body: StreamBuilder(
        stream: detailTrackBloc.allMusic,
        builder: (context, AsyncSnapshot<MusicDetailTrackModel> snapshot) {
          if (snapshot.hasData) {
            print(snapshot);
            detailBloc.fetchMusicDetail(widget.trackId.toString());
            return buildWidget(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  checkForBookmark() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bookmarkedTracks = sharedPreferences.getStringList('bookmarks') ?? [];

    for (String track in bookmarkedTracks) {
      String trackId = track.split('|')[0];
      if (trackId == widget.trackId.toString()) {
        isBookmarked = true;
        break;
      }
    }
    print(bookmarkedTracks.length);
  }

  bookmark() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isBookmarked = true;
      bookmarkedTracks.add(
          '${widget.trackId}|${widget.trackName}|${widget.albumName}|${widget.artistName}');
    });
    await sharedPreferences.setStringList('bookmarks', bookmarkedTracks);
    // print(bookmarkedTracks.length);
  }

  unBookmark() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isBookmarked = false;
      print(bookmarkedTracks.remove(
          '${widget.trackId}|${widget.trackName}|${widget.albumName}|${widget.artistName}'));
    });
    await sharedPreferences.setStringList('bookmarks', bookmarkedTracks);
    print(bookmarkedTracks.length);
  }

  @override
  void initState() {
    super.initState();
    bookmarkedTracks = <String>[];
    checkConnectivity();
    checkForBookmark();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        isConnected = result == ConnectivityResult.none ? false : true;
        if (isConnected) {
          detailTrackBloc.fetchMusicDetailTrack(widget.trackId.toString());
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
        detailTrackBloc.fetchMusicDetailTrack(widget.trackId.toString());
        isConnected = true;
      });
    }
  }

  @override
  void dispose() {
    detailBloc.dispose();
    detailTrackBloc.dispose();
    super.dispose();
  }

  Widget buildWidget(AsyncSnapshot<MusicDetailTrackModel> snapshot) {
    ThemeData theme = Theme.of(context);
    TextStyle headingTextStyle = TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.5,
        color:
            theme.brightness == Brightness.light ? Colors.black : Colors.white);
    TextStyle nonHeadingTextStyle = TextStyle(
        fontSize: 17,
        color: theme.brightness == Brightness.light
            ? Colors.black87
            : Colors.white);

    return isConnected
        ? Scaffold(
            backgroundColor: theme.brightness == Brightness.light
                ? Colors.white
                : theme.cardColor,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: headingTextStyle,
                          ),
                          Text(
                            snapshot.data.trackName,
                            style: nonHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Artist',
                            style: headingTextStyle,
                          ),
                          Text(
                            snapshot.data.artistName,
                            style: nonHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Album Name',
                            style: headingTextStyle,
                          ),
                          Text(
                            snapshot.data.albumName,
                            style: nonHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Explicit',
                            style: headingTextStyle,
                          ),
                          Text(
                            snapshot.data.explicit == 1 ? 'True' : 'False',
                            style: nonHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Rating',
                            style: headingTextStyle,
                          ),
                          Text(
                            snapshot.data.trackRating.toString(),
                            style: nonHeadingTextStyle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Lyrics',
                            style: headingTextStyle,
                          ),
                          StreamBuilder(
                            stream: detailBloc.allMusic,
                            builder: (context,
                                AsyncSnapshot<MusicDetailModel> snapshot) {
                              if (snapshot.hasData) {
                                print(snapshot);
                                return Text(
                                  snapshot.data.lyricsBody,
                                  style: nonHeadingTextStyle,
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: 150),
                                child: CircularProgressIndicator(),
                              ));
                            },
                          ),
                          SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    !isBookmarked ? bookmark() : unBookmark();
                  },
                  child: Container(
                    color: theme.brightness == Brightness.light
                        ? theme.accentColor.withOpacity(0.9)
                        : Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          isBookmarked
                              ? 'Remove from Playlist'
                              : 'Add to Playlist',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          isBookmarked
                              ? Icons.playlist_add_check
                              : Icons.playlist_add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Text(
              'No Internet Connection',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
          );
  }
}

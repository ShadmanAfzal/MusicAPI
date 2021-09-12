import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/playlist_model.dart';
import 'music_detail.dart';

class MusicPlaylist extends StatefulWidget {
  @override
  _MusicPlaylistState createState() => _MusicPlaylistState();
}

class _MusicPlaylistState extends State<MusicPlaylist> {
  SharedPreferences sharedPreferences;
  bool isBookmarked = false;
  List<String> bookmarkedTracks;
  var subscription;
  bool isConnected = true;
  List<PlaylistModel> playlistModelList;
  @override
  void initState() {
    super.initState();
    checkConnectivity();
    getBookmarkList();
    playlistModelList = List<PlaylistModel>();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      setState(() {
        isConnected = result == ConnectivityResult.none ? false : true;
      });
    });
  }

  getBookmarkList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bookmarkedTracks = sharedPreferences.getStringList('bookmarks');
    for (String track in bookmarkedTracks) {
      List<String> trackDetails = track.split('|');
      playlistModelList.add(PlaylistModel(
          trackDetails[0], trackDetails[1], trackDetails[2], trackDetails[3]));
    }

    print(playlistModelList.length);
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isConnected ? Colors.transparent : Colors.white,
      appBar: AppBar(
        title: Text('My Playlist'),
      ),
      body: isConnected
          ? buildList()
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

  Widget buildList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      itemCount: playlistModelList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        ///Return Single Widget
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return MusicDetail(
                  trackId: int.parse(playlistModelList[index].trackId),
                  trackName: playlistModelList[index].trackName,
                  albumName: playlistModelList[index].albumName,
                  artistName: playlistModelList[index].artistName,
                  index: index,
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
                        playlistModelList[index].trackName,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '- (${playlistModelList[index].albumName})',
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Artist - ${playlistModelList[index].artistName}',
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

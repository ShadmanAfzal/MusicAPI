import 'package:http/http.dart' show Client, Response;

import '../models/music_detail_model.dart';
import '../models/music_detail_track_model.dart';
import '../models/music_model.dart';

class MusicApiProvider {
  Client client = Client();
  final _apiKey = 'e5ba8973284efa94febb74f3cb2529d9';
  final _baseUrl = 'https://api.musixmatch.com/ws/1.1';

  Future<MusicModel> fetchMusicList() async {
    print('$_baseUrl/chart.tracks.get?apikey=$_apiKey');
    Response response =
        await client.get('$_baseUrl/chart.tracks.get?apikey=$_apiKey');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return MusicModel.fromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load List');
    }
  }

  Future<MusicDetailModel> fetchMusicDetail(String trackingId) async {
    print('$_baseUrl/track.lyrics.get?track_id=$trackingId&apikey=$_apiKey');
    Response response = await client
        .get('$_baseUrl/track.lyrics.get?track_id=$trackingId&apikey=$_apiKey');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(response.body.toString());
      return MusicDetailModel.fromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load List');
    }
  }

  Future<MusicDetailTrackModel> fetchMusicTrackDetail(String trackingId) async {
    print('$_baseUrl/track.get?track_id=$trackingId&apikey=$_apiKey');
    Response response = await client
        .get('$_baseUrl/track.get?track_id=$trackingId&apikey=$_apiKey');
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(response.body.toString());
      return MusicDetailTrackModel.fromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load List');
    }
  }
}

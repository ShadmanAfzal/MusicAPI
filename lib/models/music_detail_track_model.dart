class MusicDetailTrackModel {
  int _trackId;
  String _trackName;
  List<String> _trackNameTranslationList = [];
  int _trackRating;
  int _commonTrackId;
  int _instrumental;
  int _explicit;
  int _hasLyrics;
  int _hasSubtitles;
  int _hasRichSync;
  int _numFavourite;
  int _albumId;
  String _albumName;
  int _artistId;
  String _artistName;
  String _trackShareUrl;
  String _trackEditUrl;
  int _restricted;
  String _updatedTime;
  MusicDetailTrackModel.fromJson(dynamic parsedJson) {
    var result = parsedJson['message']['body']['track'];
    _trackId = result['track_id'];
    _trackName = result['track_name'];
//    for (int i = 0; i < result['track_name_translation_list'].length; i++) {
//      _trackNameTranslationList.add(result['track_name_translation_list'][i]);
//    }
    _trackRating = result['track_rating'];
    _commonTrackId = result['commontrack_id'];
    _instrumental = result['instrumental'];
    _explicit = result['explicit'];
    _hasLyrics = result['has_lyrics'];
    _hasSubtitles = result['has_subtitles'];
    _hasRichSync = result['has_richsync'];
    _numFavourite = result['num_favourite'];
    _albumId = result['album_id'];
    _albumName = result['album_name'];
    _artistId = result['artist_id'];
    _artistName = result['artist_name'];
    _trackShareUrl = result['track_share_url'];
    _trackEditUrl = result['track_edit_url'];
    _restricted = result['restricted'];
    _updatedTime = result['updated_time'];
  }

  String get updatedTime => _updatedTime;

  int get restricted => _restricted;

  String get trackEditUrl => _trackEditUrl;

  String get trackShareUrl => _trackShareUrl;

  String get artistName => _artistName;

  int get artistId => _artistId;

  String get albumName => _albumName;

  int get albumId => _albumId;

  int get numFavourite => _numFavourite;

  int get hasRichSync => _hasRichSync;

  int get hasSubtitles => _hasSubtitles;

  int get hasLyrics => _hasLyrics;

  int get explicit => _explicit;

  int get instrumental => _instrumental;

  int get commonTrackId => _commonTrackId;

  int get trackRating => _trackRating;

  List<String> get trackNameTranslationList => _trackNameTranslationList;

  String get trackName => _trackName;

  int get trackId => _trackId;
}

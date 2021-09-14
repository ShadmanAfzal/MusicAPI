class MusicDetailModel {
  int _lyricsId;
  int _explicit;
  String _lyricsBody;

  MusicDetailModel.fromJson(dynamic parsedJson) {
    _lyricsId = parsedJson['message']['body']['lyrics']['lyrics_id'];
    _explicit = parsedJson['message']['body']['lyrics']['explicit'];
    _lyricsBody = parsedJson['message']['body']['lyrics']['lyrics_body'];
  }

  String get lyricsBody => _lyricsBody;

  int get explicit => _explicit;

  int get lyricsId => _lyricsId;
}

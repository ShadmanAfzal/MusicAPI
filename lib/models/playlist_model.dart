class PlaylistModel {
  String _trackId;
  String _trackName;
  String _albumName;
  String _artistName;

  PlaylistModel(
      this._trackId, this._trackName, this._albumName, this._artistName);

  String get artistName => _artistName;

  String get albumName => _albumName;

  String get trackName => _trackName;

  String get trackId => _trackId;
}

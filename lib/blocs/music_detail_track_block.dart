import 'package:rxdart/rxdart.dart';

import '../models/music_detail_track_model.dart';
import '../resources/repository.dart';

class MusicDetailTrackBloc {
  final _repository = Repository();
  var _musicFetcher = PublishSubject<MusicDetailTrackModel>();
  bool _isDisposed = false;
  Stream<MusicDetailTrackModel> get allMusic => _musicFetcher.stream;

  fetchMusicDetailTrack(String trackingId) async {
    if (_isDisposed) {
      _musicFetcher = PublishSubject<MusicDetailTrackModel>();
    }
    MusicDetailTrackModel musicDetailTrackModel =
        await _repository.fetchMusicTrackDetails(trackingId);
    _musicFetcher.sink.add(musicDetailTrackModel);
  }

  dispose() {
    _musicFetcher.close();
    _isDisposed = true;
  }
}

final detailTrackBloc = MusicDetailTrackBloc();

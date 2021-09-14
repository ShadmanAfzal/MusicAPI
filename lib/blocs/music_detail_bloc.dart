import 'package:rxdart/rxdart.dart';

import '../models/music_detail_model.dart';
import '../resources/repository.dart';

class MusicDetailBloc {
  final _repository = Repository();
  var _musicFetcher = PublishSubject<MusicDetailModel>();
  bool _isDisposed = false;
  Stream<MusicDetailModel> get allMusic => _musicFetcher.stream;

  fetchMusicDetail(String trackingId) async {
    if (_isDisposed) {
      _musicFetcher = PublishSubject<MusicDetailModel>();
    }
    MusicDetailModel musicDetailModel =
        await _repository.fetchMusicDetails(trackingId);
    _musicFetcher.sink.add(musicDetailModel);
  }

  dispose() {
    _musicFetcher.close();
    _isDisposed = true;
  }
}

final detailBloc = MusicDetailBloc();

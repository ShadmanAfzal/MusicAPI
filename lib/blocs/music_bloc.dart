import 'package:rxdart/rxdart.dart';

import '../models/music_model.dart';
import '../resources/repository.dart';

class MusicBloc {
  final _repository = Repository();
  var _musicFetcher = PublishSubject<MusicModel>();
  bool _isDisposed = false;
  Stream<MusicModel> get allMusic => _musicFetcher.stream;

  fetchAllMusic() async {
    if (_isDisposed) {
      _musicFetcher = PublishSubject<MusicModel>();
    }
    MusicModel musicModel = await _repository.fetchAllMusic();
    _musicFetcher.sink.add(musicModel);
  }

  dispose() {
    _musicFetcher.close();
    _isDisposed = true;
  }
}

final bloc = MusicBloc();

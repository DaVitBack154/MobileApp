import 'dart:async';

class NotiEvent {
  NotiEvent._();
  static final _instance = NotiEvent._();
  static NotiEvent get instance => _instance;

  final _mController = StreamController<bool>.broadcast();
  Stream<bool> get notiEvent => _mController.stream;

  void notiChange(bool isRead) {
    _mController
      ..sink
      ..add(isRead);
  }

  void close() {
    _mController.close();
  }
}

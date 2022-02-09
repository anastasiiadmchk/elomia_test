import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class ProcessingBloc {
  final _isLoading = PublishSubject<bool>();
  final _processingResult = StreamController<bool>.broadcast();

  Stream<bool> get isLoading => _isLoading.stream;
  Stream<bool> get processingResult => _processingResult.stream;
  Timer? _timer;

  Function(bool) get setLoading => (state) {
        if (!state) {
          if (_timer != null || (_timer != null && _timer!.isActive)) {
            _timer?.cancel();
          }
          _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
            _isLoading.add(state);
            timer.cancel();
          });
        } else {
          if (_timer != null || (_timer != null && _timer!.isActive)) {
            _timer?.cancel();
          }
          _isLoading.add(state);
        }
      };
  Function(bool) get setProcessingResult => (state) {
        BlocProvider.instance.processingBloc.setLoading(false);
        _processingResult.add(state);
      };
}
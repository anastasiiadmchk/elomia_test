import 'package:elomia_test/blocs/processing_bloc.dart';

import 'auth_bloc.dart';

class BlocProvider {
  static final instance = BlocProvider();

  final authBloc = AuthBloc();
  final processingBloc = ProcessingBloc();

  BlocProvider();
}
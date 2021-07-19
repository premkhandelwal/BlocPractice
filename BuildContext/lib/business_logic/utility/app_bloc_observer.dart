import 'package:flutter_bloc/flutter_bloc.dart';

class AppBLocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
  }
}

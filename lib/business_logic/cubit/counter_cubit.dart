import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_practice/enums/enums.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit? internetCubit;
  StreamSubscription? streamSubscription;

  CounterCubit({this.internetCubit})
      : super(CounterState(counterValue: 0, wasIncremented: false)) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
      streamSubscription = internetCubit?.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.WiFi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        decrement();
      }
    });
  }
  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}

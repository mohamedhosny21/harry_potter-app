import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;

  late StreamSubscription streamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    streamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        internetConnected();
      } else if (connectivityResult == ConnectivityResult.none) {
        internetDisconnected();
      }
    });
  }

  void internetConnected() {
    emit(InternetConnectedState(message: 'Internet Connected'));
  }

  void internetDisconnected() {
    emit(InternetDisconnectedState(message: 'Internet Disconnected'));
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

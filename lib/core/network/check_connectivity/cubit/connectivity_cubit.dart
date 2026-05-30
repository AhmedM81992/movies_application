import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityCubit({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(const ConnectivityState());

  void checkInternetConnection() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final isConnected = results.any(
          (result) => result != ConnectivityResult.none,
        );
        if (isConnected) {
          emit(DeviceConnectedState(
            status: ConnectivityStatus.connected,
            isConnected: true,
          ));
        } else {
          emit(DeviceConnectedState(
            status: ConnectivityStatus.disconnected,
            isConnected: false,
          ));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
